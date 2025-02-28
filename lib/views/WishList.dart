import 'package:flutter/material.dart';
import 'package:winest/controller/WishlistController.dart';

class WishList extends StatefulWidget {
  String uid = "";
  WishList(String uid) {
    this.uid = uid;
  }
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Map<String, dynamic>> wishList;
  List<String> winesNames = [];

  WishListController _controller = WishListController();
  void getWinesNames(dynamic winesMap) {
    winesNames = [];
    for (var wine in winesMap) {
      // print(wine['title']);
      winesNames.add(wine['title']);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('cellar uid: ${widget.uid}');

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: _controller.getWines(widget.uid),
        builder: (context, snapshot) {
          if (!(snapshot.connectionState == ConnectionState.done))
            return Center(child: CircularProgressIndicator());
          wishList = snapshot.data;
          getWinesNames(wishList[0]['wishListWines']);
          // print(wishList[0]['wishListWines']);
          if (wishList[0]['wishListWines'].length == 0) {
            return Scaffold(
              backgroundColor: Color(0xFF5C115E),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset('images/no_wines_wishlist.png'),
                    SizedBox(width: 0, height: 5),
                    Text('Ooops!',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    SizedBox(width: 0, height: 60),
                    Text('Your Wishlist seems to be empty',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(width: 0, height: 5),
                    Text('Add some wines to your Wishlist',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(width: 0, height: 40),
                    Text('Tap on Discover',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(width: 0, height: 40),
                    // Container(
                    //   child: ElevatedButton(
                    //     style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all<Color>(Colors.white)),
                    //     child: const Text('Vinhos',
                    //         style:
                    //             TextStyle(color: Colors.purple, fontSize: 20)),
                    //     onPressed: () => {},
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Color(0xFF5C115E),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text(
                    'Wishlist',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(15, 0, 20, 10),
                      itemCount: winesNames.length * 2,
                      itemBuilder: (BuildContext _context, int i) {
                        if (i.isOdd) {
                          return Divider(color: Colors.white);
                        }
                        final int index = i ~/ 2;
                        return _buildRow(context, index + 1,
                            winesNames.elementAt(index)); //got here
                      }),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildRow(BuildContext context, int index, String wine) {
    return DismissibleWidget(
        item: winesNames,
        child: ListTile(
          title: Text(
            '$wine',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Icon(Icons.wine_bar_outlined, color: Colors.white),

          // Funcionalidade para listar informações do Vinho (Desenvolvimento)
          onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    elevation: 24.0,
                    backgroundColor: Color(0xFF5C115E),
                    // No title, ele vai pegar o nome do vinho selecionado através do index da listile. Usa a lista "winesTest"
                    title: Text(winesNames[index - 1],
                        style: TextStyle(color: Colors.white)),
                    content: Wrap(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xFF5C115E),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: [
                                Text('Description',
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 223, 43, 51),
                                        fontWeight: FontWeight.bold))
                              ]),
                              SizedBox(width: 0, height: 10),
                              Text(
                                  '${wishList[0]['wishListWines'][index - 1]['description']}',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(width: 0, height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Price',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 223, 43, 51),
                                            fontWeight: FontWeight.bold)),
                                    Text('Points',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 223, 43, 51),
                                            fontWeight: FontWeight.bold))
                                  ]),
                              SizedBox(width: 0, height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        '${wishList[0]['wishListWines'][index - 1]['price']}',
                                        style: TextStyle(color: Colors.white)),
                                    Text(
                                        '${wishList[0]['wishListWines'][index - 1]['points']}',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                              SizedBox(width: 0, height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Country',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 223, 43, 51),
                                            fontWeight: FontWeight.bold)),
                                    Text('Variety',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 223, 43, 51),
                                            fontWeight: FontWeight.bold))
                                  ]),
                              SizedBox(width: 0, height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      '${wishList[0]['wishListWines'][index - 1]['country']}',
                                      style: TextStyle(color: Colors.white)),
                                  Text(
                                      '${wishList[0]['wishListWines'][index - 1]['variety']}',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
        ),
        onDismissed: (direction) async {
          var data =
              await _controller.removeFromWishList(index - 1, widget.uid);
          print(data);
          setState(() {
            wishList[0]['wishListWines'] = data;
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
