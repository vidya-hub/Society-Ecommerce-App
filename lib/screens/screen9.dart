import 'package:flutter/material.dart';

class Screen9 extends StatefulWidget {
  @override
  _Screen9State createState() => _Screen9State();
}

class _Screen9State extends State<Screen9> {
  int no_of_items = 2;
  int counter = 0;
  List<String> categories = ["All", "Boutique", "Groceries"];
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
                height: 55,
                // margin: EdgeInsets.all(15.0),
                child: new ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          child: RaisedButton(
                            //autofocus: true,
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            onPressed: () {},
                            child: new Text('${categories.elementAt(i)}'),
                          ),
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                child: GridView.count(
                  childAspectRatio: (0.75),
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
                              child: Center(
                                child: Image.network(
                                  items_img_urls[index],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "    " + items_title[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "     " + shop_name,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "     " + "Rs " + items_price[index].toString(),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 22,
                                  height: 22,
                                  child: OutlineButton(
                                    onPressed: () {
                                      if (counter > 0) {
                                        counter--;
                                        setState(() {});
                                      }
                                    },
                                    child: Text(
                                      '-',
                                      textAlign: TextAlign.right,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(counter.toString()),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 22,
                                  height: 22,
                                  child: OutlineButton(
                                    onPressed: () {
                                      // have limited number of items for 10
                                      if (counter < 10) {
                                        counter++;
                                        setState(() {});
                                      }
                                    },
                                    child: Text(
                                      '+',
                                      textAlign: TextAlign.right,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.green[900],
                                    ),
                                  ),
                                ),
                              ],
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'ADD PRODUCT/SERVICES TO STORE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                                color: Colors.white60,
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {}),
                            Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                    onPressed: () {},
                    color: Colors.teal[800],
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
