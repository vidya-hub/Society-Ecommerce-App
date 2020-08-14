import 'package:flutter/material.dart';
import 'package:society/screens/categories.dart';
import 'package:society/screens/screen12.dart';
import 'package:society/screens/welcome.dart';
import 'package:society/utils/widgetCart.dart';
import 'myProducts.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

List<String> cartchoices = [
  "All",
  "Boutique",
  "Groceries",
  "Gadgets",
  "Games",
  "Books"
];

int val1 = 1;
int val2 = 1;

class _CartState extends State<Cart> {
  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id; // use this
        });
        print("from this    $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    setState(() {
      // get_user();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                new Container(
                  alignment: Alignment.topCenter,
                  child: new Text(
                    "Shweta Jewels",
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    "nrfnkj4nekcnemnmnecne lmf.mkc ckckxcl clxx \n jnesjxn4ek4nefm,cnmecjhghvvn vbjnm bbnm \n nbvbn vbnm",
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                new SizedBox(
                  height: 10,
                ),
                Container(
                  height: 55,
                  // margin: EdgeInsets.all(15.0),
                  child: new ListView.builder(
                    itemCount: cartchoices.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 40.0, 10.0),
                          child: SizedBox(
                            height: 80,
                            width: 100,
                            child: RaisedButton(
                              autofocus: true,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              onPressed: () {},
                              child: new Text(
                                '${cartchoices.elementAt(i)}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ));
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      // card1(wid * 0.9, val1),
                      Container(
                        height: 300,
                        width: (wid * 0.9) / 2,
                        child: Card(
                          elevation: 5,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: new Container(
                                  height: 200,
                                  width: (wid * 0.9) / 2,
                                  color: Colors.grey,
                                ),
                                //            child: new Image.asset('assets/user.png',
                                //              height: 200,
                                //              width: width/2 ,
                                //              fit: BoxFit.cover,
                                //            ),
                              ),
                              new ListTile(
                                title: new Text("Amul butter",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18)),
                                subtitle: new Text(
                                  "\nRs. 45 ",
                                  textAlign: TextAlign.center,
                                ),
                                contentPadding: EdgeInsets.all(5.0),
                                // trailing: new FlatButton.icon(onPressed: , icon: Icon(Icons.play_arrow), label: new Text("Play")
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new InkWell(
                                      child: Icon(
                                        Icons.arrow_left,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        //decrement value
                                        int currentValue = val1;
                                        setState(() {
                                          currentValue--;
                                          val1 = (currentValue >= 0
                                              ? currentValue
                                              : 0);
                                        });
                                      }),
                                  new Text(
                                    '$val1',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  new InkWell(
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: Colors.black,
                                    ),
                                    onTap: () {
                                      //increment value
                                      int currentValue = val1;
                                      setState(() {
                                        currentValue++;
                                        val1 = (currentValue >= 0
                                            ? currentValue
                                            : 0);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      //card1(wid * 0.9, val2)
                      Container(
                        height: 300,
                        width: (wid * 0.9) / 2,
                        child: Card(
                          elevation: 5,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: new Container(
                                  height: 200,
                                  width: (wid * 0.9) / 2,
                                  color: Colors.grey,
                                ),
                                //            child: new Image.asset('assets/user.png',
                                //              height: 200,
                                //              width: width/2 ,
                                //              fit: BoxFit.cover,
                                //            ),
                              ),
                              new ListTile(
                                title: new Text("Amul butter",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18)),
                                subtitle: new Text(
                                  "\nRs. 45 ",
                                  textAlign: TextAlign.center,
                                ),
                                contentPadding: EdgeInsets.all(5.0),
                                // trailing: new FlatButton.icon(onPressed: , icon: Icon(Icons.play_arrow), label: new Text("Play")
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new InkWell(
                                      child: Icon(
                                        Icons.arrow_left,
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        //decrement value
                                        int currentValue = val2;
                                        setState(() {
                                          currentValue--;
                                          val2 = (currentValue >= 0
                                              ? currentValue
                                              : 0);
                                        });
                                      }),
                                  new Text(
                                    '$val2',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  new InkWell(
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: Colors.black,
                                    ),
                                    onTap: () {
                                      //increment value
                                      int currentValue = val2;
                                      setState(() {
                                        currentValue++;
                                        val2 = (currentValue >= 0
                                            ? currentValue
                                            : 0);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: wid * 0.95,
            color: Colors.black,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Screen12()));
              },
              color: Colors.black,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(
                    "Review your Cart",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        new Text((val1 + val2).toString(),
                            style: TextStyle(color: Colors.white, fontSize: 17))
                      ])
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
