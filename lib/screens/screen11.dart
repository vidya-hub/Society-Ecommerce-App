import 'package:flutter/material.dart';

class Screen11 extends StatefulWidget {
  @override
  _Screen11State createState() => _Screen11State();
}

class _Screen11State extends State<Screen11> {
  int price = 42000;
  String product_name = 'Hand Jewellery';
  String shop_name = 'Swetha Jewels';
  String description =
      'This is the hand jewellery crafted from the best of the stones and pure gold. I have red blue and green color available.';
  int counter = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Image.network(
                    "https://cdn0.weddingwire.in/emp/fotos/5/4/3/1/png-jewelles21_15_205431-1568861691.jpg"),
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    product_name,
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    width: 82,
                  ),
                  Text(
                    "Rs " + price.toString(),
                    style: TextStyle(fontSize: 26),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    shop_name,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(17, 0, 22, 0),
                  child: Text(
                    description,
                    style: TextStyle(height: 1.9, fontSize: 15),
                  )),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150,
                    height: 50,
                    child: OutlineButton(
                      onPressed: () {},
                      child: Text('Back',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          )),
                      borderSide: BorderSide(color: Colors.green[900]),
                    ),
                  ),
                  SizedBox(
                    width: 50,
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
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
