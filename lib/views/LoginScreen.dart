import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Winest',
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          textColor: Colors.white,
        )
        ],
      ),
      body: Form(
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Senha"
              ),
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: (){},
                child: Text("Esqueci minha senha",
                  textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
                child: Text("Entrar",
                style: TextStyle(
                  fontSize: 18.0,
                ),
                ),
              textColor: Colors.white,
              //color: Theme.of(context).primaryColor,
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
