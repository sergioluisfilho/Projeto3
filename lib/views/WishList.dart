import 'package:flutter/material.dart';
import 'package:winest/controller/WishlistController.dart';
import 'package:winest/models/User.dart';

class WishList extends StatefulWidget {
  String uid = "";
  WishList(String uid) {
    this.uid = uid;
  }
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final List<Map<String, dynamic>> winesList = [{}];
  final List<String> winesTest = ['Wine 1', 'Wine 2', 'Wine 3', 'Wine 4'];

  WishListController _controller = WishListController();

  @override
  Widget build(BuildContext context) {
    print('Wish List uid: ${widget.uid}');
    if (winesTest.length == 0) {
      return Scaffold(
        backgroundColor: Color(0xFF5C115E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/no_wines_wishlist.png'),
              SizedBox(width: 0, height: 5),
              Text('Ooops!',
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              SizedBox(width: 0, height: 60),
              Text('Não há vinhos por aqui',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              SizedBox(width: 0, height: 5),
              Text('Adicione novos vinhos à sua Wishlist',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              SizedBox(width: 0, height: 40),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  child: const Text('Vinhos',
                      style: TextStyle(color: Colors.purple, fontSize: 20)),
                  onPressed: () => {},
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF5C115E),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextFormField(
              cursorColor: Colors.purple,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Type the wine's name",
                hintStyle: TextStyle(fontSize: 12, color: Colors.black),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.wine_bar, color: Colors.purple),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(15, 0, 20, 10),
                itemCount: winesTest.length * 2,
                itemBuilder: (BuildContext _context, int i) {
                  if (i.isOdd) {
                    return Divider(color: Colors.white);
                  }
                  final int index = i ~/ 2;
                  return _buildRow(
                      context, index + 1, winesTest.elementAt(index));
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index, String wine) {
    return DismissibleWidget(
        item: winesTest,
        child: ListTile(
            title: Text(
              '${wine}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            trailing: Icon(Icons.favorite, color: Colors.white)),
        onDismissed: (direction) {
          setState(() {
            _controller.removeFromWishList(index, widget.uid);
          });
        });
  }
}

class DismissibleWidget<tile> extends StatelessWidget {
  final tile item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    @required this.item,
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        direction: DismissDirection.startToEnd,
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white.withOpacity(0.7),
        child: Icon(Icons.delete),
      );
}
