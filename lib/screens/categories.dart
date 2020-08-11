import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/cart.dart';
class Categories extends StatefulWidget {
  
  var number;
  Categories({Key: Key, this.number});

  @override
  _CategoriesState createState() => _CategoriesState();
}
List<String> categories = [
  "All",
  "Boutique",
  "Groceries",
  "Gadgets",
  "Games",
  "Books"
];
List<Widget> _widgetList = [];
  
  int _currrentIndex = 0;
var address="";
var state="";
var society_name="";

class _CategoriesState extends State<Categories> {

  @override
  void initState() {
    print("${widget.number} phone no");
    super.initState();
    get_data();
  }

  final _store = Firestore.instance.collection("users");

  get_data() async {
    var _data = await _store.document(widget.number).snapshots();

    await for (var datastream in _data) {
      setState(() {
        address = datastream["address"];
        state = datastream["state"];
        society_name = datastream["societyname"];
      });
      print(address);
      print(state);
      print(society_name);
    }
  }


  @override
  Widget build(BuildContext context) {
    //final prodProvider = Provider.of<Product>(context);
    //final prodList = prodProvider.items;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: _currrentIndex,
        onTap: (index) {
          setState(() {
            _currrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black),
              title: new Text("Explore",
                  style: new TextStyle(
                      color: Colors.black
                  )
              )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,  color: Colors.black),
              title: new Text("My Store",
                  style: new TextStyle(
                      color: Colors.black
                  ))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black,),
                  title: new Text("Profile",
                      style: new TextStyle(
                          color: Colors.black
                      ))
          ),
        ],
      ),
      body:
           Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child : Column(
              children:<Widget> [
                Container(
                  color: Colors.white,
                  height: 40
                ),
                Address(address, state, society_name, wid),
                new SizedBox(height: 20,),
                new Text("Top Item Categories",
                  style: TextStyle(
                    color: Colors.grey,

                    fontSize: 14,

                  ),
                ),
              new SizedBox(height: 10,),
                Container(
                  height: 55,
                  // margin: EdgeInsets.all(15.0),
                  child: new ListView.builder(itemCount: categories.length , itemBuilder:(BuildContext context, int i){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0,10.0,40.0,10.0),
                      child: SizedBox(
                        height: 80,
                        width: 90,
                        child: RaisedButton(
                          autofocus: true,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          onPressed: (){

                          },
                          child: new Text('${categories.elementAt(i)}'),
                        ),
                      )
                    );
                  },
                    scrollDirection: Axis.horizontal,),
                ),
                Container(
                  width: wid,
                  child: new Row(

                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(5.0),),
                       card(wid*0.9, context),
                      Padding(padding: EdgeInsets.all(5.0),),
                      card(wid*0.9, context)
                    ],
                  ),
                )
              ]
            )
          ),


    );
  }
}
Widget Address(String socname,String state, String city,  double width){
  return Container(
    height: 75,
    width: width ,
    color: Colors.white,

     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             new SizedBox(height: 20,),
             Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),),
             Row(
               children: [new Text(socname, style: new TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.bold,

               ),),
               new GestureDetector(
                 onTap: (){
                   //change address
                 },
                 child: new Text("(change)",
                 style: new TextStyle(
                   color: Colors.lightBlueAccent,
                     fontSize: 18,
                     fontWeight: FontWeight.bold,

                 ),),
               ),

               ]
             ),
             new Text(
               city + state,
               style: TextStyle(
                 color: Colors.grey,

               ),

             )
           ],

         ),
         new CircleAvatar(
           backgroundColor: Colors.grey.shade400,
           child: Icon(Icons.search,
           color: Colors.black,),
         )
       ],
     ),
  );
}
Container card(double width, BuildContext context){
  return Container(
    height: 300,
    width: width/2,
      child:  Card(
      elevation: 5,
      child: new Column(
        children: [

          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart() ));
      },
              child: new Container(
                height: 200,
                width: width/2 ,
                color: Colors.grey,
              ),
            ),
//            child: new Image.asset('assets/user.png',
//              height: 200,
//              width: width/2 ,
//              fit: BoxFit.cover,
//            ),
          ),
          new ListTile(
              title: new Text("Shweta Groceries",
                  style : new TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 20)),
              subtitle: new Text("\nAll the "),
              contentPadding: EdgeInsets.all(5.0),
             // trailing: new FlatButton.icon(onPressed: , icon: Icon(Icons.play_arrow), label: new Text("Play")

              )
]),
      ));

}