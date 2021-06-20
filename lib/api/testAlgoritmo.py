import plotly.express as px
import pandas as pd  # data processing, CSV file I/O (e.g. pd.read_csv)
import numpy as np  # linear algebra
from tensorflow.compat.v1 import InteractiveSession
from tensorflow.compat.v1 import ConfigProto
import os
import re
import sklearn.model_selection as sk
import matplotlib.style as style
import pandas as pd  # data processing, CSV file I/O (e.g. pd.read_csv)
import numpy as np  # linear algebra
import tensorflow as tf
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import norm

#!pip install flask-ngrok

from flask_ngrok import run_with_ngrok
from flask import Flask
from flask import request
import random


dataset = pd.read_csv('lib/api/winemag-data-130k-v2.csv')


# This Python 3 environment comes with many helpful analytics libraries installed
# It is defined by the kaggle/python docker image: https://github.com/kaggle/docker-python


# Input data files are available in the "../input/" directory.
print("Input files:")
for dirname, _, filenames in os.walk('/kaggle/input'):
    for filename in filenames:
        print(os.path.join(dirname, filename))

# Any results you write to the current directory are saved as output.

# For neural nets with my GPU, RNN doesn't work without this in TF 2.0
config = ConfigProto()
config.gpu_options.allow_growth = True
session = InteractiveSession(config=config)

print()
print("TF Version: ", tf.__version__)
print("Eager mode: ", tf.executing_eagerly())
print("GPU is", "available" if tf.config.experimental.list_physical_devices(
    "GPU") else "NOT AVAILABLE")

if tf.test.gpu_device_name():
    print('GPU found')
else:
    print("No GPU found")


path_to_file = 'lib/api/winemag-data-130k-v2.csv'

dfWine = pd.read_csv(path_to_file, index_col=0)


# Read title and find vintage
yearSearch = []
for value in dfWine['title']:
    regexresult = re.search(r'19\d{2}|20\d{2}', value)
    if regexresult:
        yearSearch.append(regexresult.group())
    else:
        yearSearch.append(None)

dfWine['year'] = yearSearch

# Tell me which ones don't have a year listed
print("We extracted %d years from the wine titles and %d did not have a year." % (
    len(dfWine[dfWine['year'].notna()]), len(dfWine[dfWine['year'].isna()].index)))
dfWine['year'].describe()


# If we're missing year values, remove the row
dfWine_goodyears = dfWine
dfWine_goodyears = dfWine_goodyears.dropna(subset=['year'])
print('Removed ' + str(dfWine.shape[0]-dfWine_goodyears.shape[0]
                       ) + ' rows with empty year values.' + "\n")

dfWine_goodyears['year'] = dfWine_goodyears['year'].astype(int)
# dfWine_goodyears['year']=pd.to_numeric(dfWine_goodyears['year'], downcast='integer', errors='coerce')

print(dfWine_goodyears['year'].describe())

dfWineYear = dfWine_goodyears.groupby(['year']).mean()
dfWineYear = pd.DataFrame(data=dfWineYear).reset_index()


# Get label frequencies in descending order
label_freq = dfWine['variety'].apply(lambda s: str(
    s)).explode().value_counts().sort_values(ascending=False)

# Bar plot
style.use("fivethirtyeight")
plt.figure(figsize=(12, 10))
sns.barplot(y=label_freq.index.values, x=label_freq,
            order=label_freq.iloc[:15].index)
plt.title("Grape frequency", fontsize=14)
plt.xlabel("")
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.show()


dfWineClassifier = dfWine[['description',
                           'year', 'variety', 'country', 'province']]

# Tell us where we have missing or NaN values (isnull or isna):
print(dfWineClassifier.isnull().sum())
print()

# Tell me which ones don't have a variety listed
print("Missing entries: %d" %
      (dfWineClassifier[dfWineClassifier['variety'].isna()].index[0]))
print(dfWineClassifier[dfWineClassifier['variety'].isna()].head(10))
print()

# pd.DataFrame(dfWineClassifier.variety.unique()).values

# If we're missing important values, remove the row
dfWineClassifier = dfWineClassifier.dropna(subset=['description', 'variety'])
print('Removed ' +
      str(dfWine.shape[0]-dfWineClassifier.shape[0]) + ' rows with empty values.' + "\n")


# It must have this many examples of the grape variety, otherwise it's "other."
RARE_CUTOFF = 700

# Create a list of rare labels
rare = list(label_freq[label_freq < RARE_CUTOFF].index)
# print("We will be ignoring these rare labels: \n", rare)


# Transform the rare ones to just "Other"
dfWineClassifier['variety'] = dfWineClassifier['variety'].apply(
    lambda s: str(s) if s not in rare else 'Other')

label_words = list(label_freq[label_freq >= RARE_CUTOFF].index)
label_words.append('Other')
print(label_words)

num_labels = len(label_words)
print("\n" + str(num_labels) + " different categories.")

# pd.DataFrame(dfWineClassifier.variety.unique()).values


# length of dictionary
NUM_WORDS = 4000

# Length of each review
SEQ_LEN = 256

# create tokenizer for our data
tokenizer = tf.keras.preprocessing.text.Tokenizer(
    num_words=NUM_WORDS, oov_token='<UNK>')
tokenizer.fit_on_texts(dfWineClassifier['description'])

# convert text data to numerical indexes
wine_seqs = tokenizer.texts_to_sequences(dfWineClassifier['description'])

# pad data up to SEQ_LEN (note that we truncate if there are more than SEQ_LEN tokens)
wine_seqs = tf.keras.preprocessing.sequence.pad_sequences(
    wine_seqs, maxlen=SEQ_LEN, padding="post")

print(wine_seqs)


# Creating a mapping from unique words to indices
# char2idx = {u:i for i, u in enumerate(label_words)}
# print(char2idx)
# idx2char = np.array(label_words)
# print(idx2char)

# print(str(len(idx2char)) + ' wine styles.')

wine_labels = pd.DataFrame({'variety': dfWineClassifier['variety']})
# wine_labels=wine_labels.replace({'variety' : char2idx})
wine_labels = wine_labels.replace(' ', '_', regex=True)

wine_labels_list = []
for item in wine_labels['variety']:
    wine_labels_list.append(str(item))

label_tokenizer = tf.keras.preprocessing.text.Tokenizer(
    split=' ', filters='!"#$%&()*+,./:;<=>?@[\\]^`{|}~\t\n')
label_tokenizer.fit_on_texts(wine_labels_list)

print(len(label_words))
print(label_tokenizer.word_index)

wine_label_seq = np.array(label_tokenizer.texts_to_sequences(wine_labels_list))
wine_label_seq.shape


reverse_word_index = dict([(value, key)
                          for (key, value) in tokenizer.word_index.items()])


def decode_article(text):
    return ' '.join([reverse_word_index.get(i, '?') for i in text])


reverse_label_index = dict(
    [(value, key) for (key, value) in label_tokenizer.word_index.items()])


def decode_label(text):
    return ' '.join([reverse_label_index.get(i, '?') for i in text])


# Demonstrate what the input looks like, how it gets encoded.

test_entry = 3

print(decode_article(wine_seqs[test_entry]))
print('---')
print(wine_seqs[test_entry])

print(decode_label(wine_label_seq[test_entry]))
print('---')
print(wine_label_seq[test_entry])


# Divide into two
X_train, X_test, y_train, y_test = sk.train_test_split(wine_seqs,
                                                       wine_label_seq,
                                                       test_size=0.20,
                                                       random_state=42)

print('Test: ' + str(len(X_test)) + ' Train: ' + str(len(X_train)))

X_train = X_train.astype("float32")
X_test = X_test.astype("float32")
y_train = y_train.astype("float32")
y_test = y_test.astype("float32")

print(type(X_train), X_train.shape)

# X_train = X_train / 1024.0
# X_test = X_test / 1024.0
# y_train = y_train / 1024.0
# y_test = y_test / 1024.0

print(X_train.shape)
print(y_train.shape)


EMBEDDING_SIZE = 256
EMBEDDING_SIZE_2 = 64
EMBEDDING_SIZE_3 = (num_labels+1)
BATCH_SIZE = 512  # This can really speed things up
EPOCHS = 10
LR = 1e-5  # Keep it small when transfer learning

# model = tf.keras.Sequential([
#     tf.keras.layers.Embedding(NUM_WORDS, EMBEDDING_SIZE),
#     tf.keras.layers.GlobalAveragePooling1D(),
#     tf.keras.layers.Dense(1, activation='relu', name='output')])
# #    tf.keras.layers.Dense(1, activation='sigmoid')])
# #    tf.keras.layers.Dense(len(idx2char), activation='relu', name='hidden_layer')])

# https://towardsdatascience.com/multi-class-text-classification-with-lstm-using-tensorflow-2-0-d88627c10a35
model = tf.keras.Sequential([

    # Add an Embedding layer expecting input vocab of a given size, and output embedding dimension of fized size we set at the top
    tf.keras.layers.Embedding(NUM_WORDS, EMBEDDING_SIZE),
    #     tf.keras.layers.Embedding(input_dim=NUM_WORDS,
    #                            output_dim=EMBEDDING_SIZE,
    #                            input_length=SEQ_LEN),

    #     tf.keras.layers.Bidirectional(tf.keras.layers.LSTM(EMBEDDING_SIZE)),
    tf.keras.layers.Conv1D(128, 5, activation='relu'),
    tf.keras.layers.GlobalMaxPooling1D(),

    # use ReLU in place of tanh function since they are very good alternatives of each other.
    tf.keras.layers.Dense(EMBEDDING_SIZE_2, activation='relu'),

    # Add a Dense layer with additional units and softmax activation.
    # When we have multiple outputs, softmax convert outputs layers into a probability distribution.
    tf.keras.layers.Dense(EMBEDDING_SIZE_3, activation='softmax')
])

model.summary()

model.compile(optimizer='adam',
              #                optimizer=tf.keras.optimizers.Adam(learning_rate=LR),
              #               loss='binary_crossentropy',
              loss='sparse_categorical_crossentropy',
              #               loss=tf.losses.BinaryCrossentropy(from_logits=True),
              metrics=['accuracy'])


# Directory where the checkpoints will be saved
checkpoint_dir = './checkpoints/classifer_training_checkpoints'
# Name of the checkpoint files
checkpoint_prefix = os.path.join(checkpoint_dir, "ckpt_{epoch}")

checkpoint_callback = tf.keras.callbacks.ModelCheckpoint(
    filepath=checkpoint_prefix,
    monitor='accuracy',
    save_best_only=True,
    mode='auto',
    save_weights_only=True)

history = model.fit(X_train, y_train,
                    batch_size=BATCH_SIZE,
                    epochs=EPOCHS,
                    validation_data=(X_test, y_test),
                    validation_steps=30,
                    callbacks=[checkpoint_callback])

# es = tf.keras.callbacks.EarlyStopping(monitor='val_accuracy', mode='max')
# callbacks=[es]
# history = model.fit(X_train, y_train,
#                     batch_size=BATCH_SIZE,
#                     epochs=EPOCHS,
#                     validation_data=(X_test, y_test),
#                     callbacks=callbacks)

loss, accuracy = model.evaluate(X_test, y_test)

print("Loss: ", loss)
print("Accuracy: ", accuracy)


tf.train.latest_checkpoint(checkpoint_dir)

model.load_weights(tf.train.latest_checkpoint(checkpoint_dir))

model.build(tf.TensorShape([1, None]))

model.summary()


def testPredict(new_review):
    encoded_sample_pred_text = tokenizer.texts_to_sequences(new_review)
    # Some models need padding, some don't - depends on the embedding layer.
    encoded_sample_pred_text = tf.keras.preprocessing.sequence.pad_sequences(
        encoded_sample_pred_text, maxlen=SEQ_LEN, padding="post")
    predictions = model.predict(encoded_sample_pred_text)

    grapeeList = []

    for n in reversed((np.argsort(predictions))[0]):
        predicted_id = [n]
        grapee = decode_label(predicted_id).replace('_', ' ')
        #grapeePrint = print("Guess: %s \n Probability: %f" %(decode_label(predicted_id).replace('_', ' '), 100*predictions[0][predicted_id][0]) + '%')
        grapeeList.append(grapee)
        #print("Guess: %s \n Probability: %f" %(decode_label(predicted_id).replace('_', ' '), 100*predictions[0][predicted_id][0]) + '%')

    return grapeeList


new_review = [
    'Tart cherry and light, with velvety mushroom with lingering tannins.']

grapeeList = testPredict(new_review)

print(grapeeList)
