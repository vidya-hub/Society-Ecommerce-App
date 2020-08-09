import 'package:flutter/material.dart';
import 'package:society/screens/add_store.dart';
import '../screens/add_store.dart';
import 'add_product_screen.dart';

class Screen13 extends StatefulWidget {
  @override
  _Screen13State createState() => _Screen13State();
}

class _Screen13State extends State<Screen13> {
  int no_of_items = 2;
  List<String> items_img_urls = [
    "https://cdn0.weddingwire.in/emp/fotos/5/4/3/1/png-jewelles21_15_205431-1568861691.jpg",
    "https://cdn0.weddingwire.in/emp/fotos/5/4/3/1/png-jewelles21_15_205431-1568861691.jpg"
  ];
  List<String> items_title = ["Hand Jewelry", "Blouse Fitting"];
  List<int> items_price = [2500, 700];
  String shop_name = "Swetha's Jewels";
  //main description
  String description =
      "This is the hand jewellery crafted from the best of the stones and pure gold. I have red blue and green color available.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.black,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.card_travel, color: Colors.black),
      //         title:
      //             new Text("Buy", style: new TextStyle(color: Colors.black))),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.store, color: Colors.black),
      //         title: new Text("My Store",
      //             style: new TextStyle(color: Colors.black))),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.format_list_bulleted,
      //           color: Colors.black,
      //         ),
      //         title: new Text("My Order",
      //             style: new TextStyle(color: Colors.black))),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.person,
      //           color: Colors.black,
      //         ),
      //         title: new Text("Profile",
      //             style: new TextStyle(color: Colors.black))),
      //   ],
      // ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                // header image or main image
                child: Image.network(
                    "https://cdn0.weddingwire.in/emp/fotos/5/4/3/1/png-jewelles21_15_205431-1568861691.jpg"),
              ),
              SizedBox(
                height: 26,
              ),
              Center(
                child: Text(
                  shop_name,
                  style: TextStyle(fontSize: 26),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                child: Text(
                  description,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.fromLTRB(17, 0, 22, 0),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                child: GridView.count(
                  childAspectRatio: (0.85),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(no_of_items, (index) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Image.network(
                                items_img_urls[index],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              items_title[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              shop_name,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Rs " + items_price[index].toString(),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                child: SizedBox(
                  width: 400,
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      'ADD PRODUCT/SERVICES TO STORE',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    onPressed: () {
                       Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>AddProductScreen()));
                    },
                    color: Colors.green[700],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
