import 'package:flutter/material.dart';
import 'package:society/screens/categories.dart';
import 'package:society/screens/screen8.dart';
import 'package:society/screens/welcome.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String name;
final _nameController = TextEditingController(text: '');
String _selectedGender; // Option 2
List<String> genderlist = ["Male", "Female", "Others"];

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                      color: Colors.white,
                      width: 80,
                      height: 80,

                      // We will put the network image here for the profile
                      // This is just a demo image
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/dummyprofile.jpg"),
                        radius: 45,
                      ),
                    ),
                  ),
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
