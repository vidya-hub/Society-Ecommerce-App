import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:society/models/SocietyModel.dart';
import 'package:society/screens/categories.dart';
import 'package:society/screens/profilepage.dart';
import 'package:society/screens/welcome.dart';
import 'package:society/utils/citystatelist.dart';

final usersRef = Firestore.instance.collection('users');

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class SelectSocietyPage extends StatefulWidget {
  final String type, id;
  const SelectSocietyPage({Key key, this.type, this.id});

  @override
  _SelectSocietyPageState createState() => _SelectSocietyPageState();
}

class _SelectSocietyPageState extends State<SelectSocietyPage> {
  String _selectedcity = "Delhi, India";
  String address, lat, lon;
  final addressController = TextEditingController(text: '');
  String _selectedstate;
  String _selectsociety;
  String society;
  final societyController = TextEditingController(text: '');
  SocietyModel societyModel;

  final _auth = FirebaseAuth.instance;
  FirebaseUser log_user;
  String type;
  Map _pickedLocation;

  @override
  void initState() {
    // get_user();
    // get_id();
    print("init");
    super.initState();
  }

  getLocationWithNominatim() async {
    Map result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return NominatimLocationPicker(
            awaitingForLocation:
                "Turn On your Location First and then search above!",
          );
        });
    if (result != null) {
      setState(() => _pickedLocation = result);
      lat = result['latlng'].latitude.toString();
      lon = result['latlng'].longitude.toString();
      print(result);
    } else {
      print("select");
    }
  }

  List<Item> users = <Item>[
    const Item(
      'Add',
      Icon(MdiIcons.plusCircleOutline),
    ),
    const Item(
      'Swetha Jewels',
      Icon(MdiIcons.laserPointer),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        "assets/add-group.png",
                        color: Colors.black,
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
                      "Select Your Society",
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
                      "Select City",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: "Times new Roman"),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await getLocationWithNominatim();
                  var api_key_main = await Firestore.instance
                      .collection("api_key")
                      .document("api_key")
                      .get();
                  String key = api_key_main.data["key"];
                  http.Response res = await http.get(
                      "https://us1.locationiq.com/v1/reverse.php?key=$key&lat=$lat&lon=$lon&format=json");
                  setState(() {
                    if (jsonDecode(res.body)["address"]["city"] == null) {
                      _selectedcity = jsonDecode(res.body)["address"]
                              ["county"] +
                          ", " +
                          jsonDecode(res.body)["address"]["state"] +
                          ", " +
                          jsonDecode(res.body)["address"]["country"];
                    } else {
                      _selectedcity = jsonDecode(res.body)["address"]["city"] +
                          ", " +
                          jsonDecode(res.body)["address"]["state"] +
                          ", " +
                          jsonDecode(res.body)["address"]["country"];
                    }
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: <Widget>[Text(_selectedcity)],
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Select Your Society",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontFamily: "Times new Roman")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextField(
                  controller: societyController,
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Society:",
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Full Address",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontFamily: "Times new Roman")),
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
                      address = value;
                    },
                    keyboardType: TextInputType.text,
                    controller: addressController,
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
                    Text(
                      "Select State",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: "Times new Roman"),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('State'), // Not necessary for Option 1
                  value: _selectedstate,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedstate = newValue;
                    });
                  },
                  items: states.map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.1,
                // alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Text(
                    "DONE",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times new Roman",
                        fontSize: 15.0),
                  ),
                  // color: Colors.white,
                  color: Color.fromRGBO(1, 44, 50, 0.8),
                  onPressed: () async {
                    await Firestore.instance
                        .collection("Users")
                        .document(widget.id)
                        .updateData({
                      "User_city": _selectedcity,
                      "society_name": societyController.text,
                      "full_address": addressController.text,
                      "User_state": _selectedstate,
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage(id: widget.id,)));
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
