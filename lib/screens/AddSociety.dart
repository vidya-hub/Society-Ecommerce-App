import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/categories.dart';
import '../utils/citystatelist.dart';

class AddSociety extends StatefulWidget {
  static const routeName = '/AddSociety';
  @override
  _AddSocietyState createState() => _AddSocietyState();
}

class _AddSocietyState extends State<AddSociety> {
  String errorMessage = '';
  String successMessage = '';
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  String _selectedLocation; // Option 2
  String _selectedstate; // Option 2
  String _address;
  String _name;
  final _addressController = TextEditingController(text: '');
  final _nameController = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    //  _selectedLocation = _locations[0];
    //  _selectedstate = _state[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 243, 244, 1.0),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 80.0),
                child: Center(
                  child: Image.asset(
                    "assets/add-group.png",
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 5),
                  child: Center(
                      child: Text(
                    "Add Your Society",
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ))),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: formStateKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                validator: valiadetName,
                                onSaved: (value) {
                                  _name = value;
                                },
                                keyboardType: TextInputType.text,
                                controller: _nameController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.people, color: Colors.black),
                                  hintText: "Enter the name of your Society",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                validator: validateAddress,
                                onSaved: (value) {
                                  _address = value;
                                },
                                keyboardType: TextInputType.multiline,
                                controller: _addressController,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.add_location,
                                    color: Colors.black,
                                  ),
                                  hintText: "Enter your address",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                  'Please choose a City'), // Not necessary for Option 1
                              value: _selectedLocation,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue;
                                });
                              },
                              items: city.map((location) {
                                return DropdownMenuItem(
                                  child: Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: MediaQuery.of(context).size.width *
                                0.8, //gives the width of the dropdown button

                            child: DropdownButton(
                              // Not necessary for Option 1
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
                              hint: Text('Please choose a State'),
                              isExpanded: true,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              child: Text(
                                "Verify Society",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              color: Colors.black,
                              onPressed: () {
                                if (formStateKey.currentState.validate()) {
                                  formStateKey.currentState.save();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Categories()));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    (errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()),
                  ],
                ),
              ),
              (successMessage != ''
                  ? Text(
                      successMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.green),
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

  String valiadetName(String value) {
    if (value.isEmpty)
      return 'Name Should not be empty!!!';
    else
      return null;
  }

  String validateAddress(String value) {
    if (value.trim().isEmpty) {
      return "Address should not be empty";
    }
    return null;
  }
}
