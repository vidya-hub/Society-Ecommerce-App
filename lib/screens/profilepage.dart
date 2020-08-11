import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society/screens/categories.dart';
import 'package:society/screens/screen8.dart';
import 'package:society/screens/welcome.dart';

final usersRef = Firestore.instance.collection('users');

class ProfilePage extends StatefulWidget {
  final String phone_no;
  const ProfilePage({
    Key key,
    this.phone_no,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String name;
final _nameController = TextEditingController(text: '');
String _selectedGender; // Option 2
List<String> genderlist = ["Male", "Female", "Others"];

File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // setState(() {
    //   _image = File(pickedFile.path);
    // });
  }

  //  @override
  // void initState() {
  //   //super.initState();
  //   // updateDataInFirestore();
  // }

  // updateDataInFirestore() async {
  //   await usersRef
  //       .document(widget.phone_no)
  //       .updateData({"gender": _selectedGender, "name": _nameController.text});
  // }


class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical:20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.black12,
                            child: _image != null
                                ? ClipOval(
                                    child: SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : ClipOval(
                                    child: SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: Image(
                                      image: AssetImage(
                                        'assets/dummyprofile.jpg',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.camera,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Basic Profile Information",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times new Roman"),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your Name",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: "Times new Roman"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    // validator: valiadetName,
                    onSaved: (value) {
                      name = value;
                    },
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Select Gender",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontFamily: "Times new Roman")),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                      'Please Select Your Gender'), // Not necessary for Option 1
                  value: _selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  items: genderlist.map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.1,
                // alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Text(
                    "COMPLETE",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times new Roman",
                        fontSize: 15.0),
                  ),
                  // color: Colors.white,
                  color: Color.fromRGBO(1, 44, 50, 0.8),
                  onPressed: () {
                      // updateDataInFirestore();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Screen8()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
