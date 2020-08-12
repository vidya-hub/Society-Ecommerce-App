import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:society/screens/add_product_screen.dart';
import 'package:society/screens/screen13.dart';
import 'package:society/screens/screen16.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  String _name;
  final _nameController = TextEditingController(text: '');
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  var selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(6.0),
        // padding: const EdgeInsets.only(top: 40.0, left: 6.0),
        child: ListView(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  // padding: EdgeInsets.only(top: 6.0),

                  height: MediaQuery.of(context).size.height * 0.40,

                  color: Colors.grey[300],

                  width: double.infinity,

                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.add_a_photo,
                                size: 40.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Text(
                                'Add a Store image',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Image.file(
                          _image,

                          // width: MediaQuery.of(context).size.width,

                          // height: MediaQuery.of(context).size.height * 0.34,

                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 327, 21.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                Widget>[
              TextFormField(
                cursorColor: Colors.black,
                validator: validatetName,
                onSaved: (value) {
                  _name = value;
                },
                keyboardType: TextInputType.text,
                controller: _nameController,
                decoration: InputDecoration(
                    // icon: Icon(Icons.people, color: Colors.black),
                    labelText: "Add Store Title",
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              ),
              TextFormField(
                cursorColor: Colors.black,
                validator: validatetName,
                onSaved: (value) {
                  _name = value;
                },
                keyboardType: TextInputType.text,
                controller: _nameController,
                decoration: InputDecoration(
                    // icon: Icon(Icons.people, color: Colors.black),
                    labelText: "Add store decription",
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Container(
                    width: 370,
                    height: 60,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10),
                        border: Border.all(color: Colors.lightGreen, width: 2)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Store Category",
                              style: TextStyle(
                                  fontSize: 17, fontFamily: "Times new Roman"),
                              textAlign: TextAlign.left,
                            ),
                            //
                            SizedBox(height: 20.0),
                            StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection("category2")
                                  .snapshots(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text("Loading.....");
                                else {
                                  List<DropdownMenuItem> categoryItems = [];
                                  for (int i = 0;
                                      i < snapshot.data.documents.length;
                                      i++) {
                                    DocumentSnapshot snap =
                                        snapshot.data.documents[i];
                                    categoryItems.add(
                                      DropdownMenuItem(
                                        child: Text(
                                          snap.documentID,
                                          style: TextStyle(),
                                        ),
                                        value: "${snap.documentID}",
                                      ),
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Icon(FontAwesomeIcons.coins,
                                      //     size: 25.0, color: Color(0xff11b719)),
                                      SizedBox(width: 20.0),
                                      DropdownButton(
                                        items: categoryItems,
                                        onChanged: (categoryValue) {
                                          final snackBar = SnackBar(
                                            content: Text(
                                              'Selected store Category is $categoryValue',
                                              style: TextStyle(
                                                  color: Color(0xff11b719)),
                                            ),
                                          );

                                          setState(() {
                                            selectedCategory = categoryValue;
                                          });
                                          Scaffold.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        value: selectedCategory,
                                        isExpanded: false,
                                        hint: new Text(
                                          "Select category",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            //
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Color.fromRGBO(1, 44, 50, 0.8),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Screen13()),
                    );
                  },
                  child: Text(
                    'CREATE STORE NOW',
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

String validatetName(String value) {
  if (value.isEmpty)
    return 'Name Should not be empty!!!';
  else
    return null;
}
