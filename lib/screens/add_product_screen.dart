import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.all(6),
        child: Column(children: <Widget>[
          Stack(
            children: [
              Container(
                // padding: EdgeInsets.only(top: 6.0),

                height: MediaQuery.of(context).size.height * 0.60,

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
          Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                    labelText: "Write Product Name",
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(
                'Shweta Jewls',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              //Text('Write description about the product', style: TextStyle(color: Colors, fontSize:18, fontWeight: FontWeight.bold),),

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
                    labelText: "Write description about the product",
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    labelText: "Price",
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          )),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              //color: Colors.black,
              color: Color.fromRGBO(1, 44, 50, 0.8),
              onPressed: () {},
              child: Text(
                'ADD TO MY STORE',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

String validatetName(String value) {
  if (value.isEmpty)
    return 'Name Should not be empty!!!';
  else
    return null;
}
