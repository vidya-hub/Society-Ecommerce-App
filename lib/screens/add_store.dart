import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import './screen8.dart';
import './storecreated.dart';
import '../screens/screen13.dart';
import 'package:image/image.dart' as Img;
import '../screens/welcome.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

final _auth = FirebaseAuth.instance;
FirebaseUser log_user;
String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddStoreState extends State<AddStore> {
  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          _sending = true;
          currentgoogleuserid = value.id;
          get_store(currentgoogleuserid);
        });
        print("this page $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    super.initState();
  }

  get_store(id) async {
    final _exists =
        await Firestore.instance.collection("AddStore").document(id).get();
    print(id);
    print(_exists.data);
    if (_exists.exists) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen13(),
        ),
      );
      setState(() {
        _sending = false;
      });
    } else {
      setState(() {
        _sending = false;
      });
    }
  }

  var updatedDt;
  var addDt = DateTime.now();
  var newFormat = DateFormat("dd-MMMM-y");

  String _name;
  final _nameController = TextEditingController(text: '');
  final _desccontroller = TextEditingController();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  var selected_value;
  final StorageReference storageRef = FirebaseStorage.instance.ref();
  final storeRef = Firestore.instance.collection('AddStore');
  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img.Image imageFile = Img.decodeImage(_image.readAsBytesSync());

    final compressedImageFile = File('$path/img_$currentgoogleuserid')
      ..writeAsBytesSync(Img.encodeJpg(imageFile, quality: 85));

    setState(() {
      _image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask = storageRef
        .child('store')
        .child('post_$currentgoogleuserid.jpg')
        .putFile(imageFile);

    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;

    String downloadUrl = await storageSnap.ref.getDownloadURL();

    return downloadUrl;
  }

  createPostInFirestore(
      {String mediaUrl,
      String title,
      String description,
      String mobileNo}) async {
    await Firestore.instance
        .collection("AddStore")
        .document(currentgoogleuserid) //this is the id of google sign in
        .setData(
      {
        'createdAt': newFormat.format(addDt),
        'ownerUserId': currentgoogleuserid,
        'storeName': _nameController.text,
        's_photoUrl': mediaUrl,
        'storeDescription': _desccontroller.text,
        "selected-category": selected_value,
      },
    );
  }

  var selectedCategory;
  @override
  storeData() async {
    await compressImage();

    String mediaUrl = await uploadImage(_image);

    createPostInFirestore(
      mediaUrl: mediaUrl,
      title: _nameController.text,
      description: _desccontroller.text,
    );

    _nameController.clear();
    _desccontroller.clear();
  }

  bool _sending = false;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: ModalProgressHUD(
        opacity: 0.6,
        progressIndicator: RefreshProgressIndicator(),
        inAsyncCall: _sending,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListView(
            children: <Widget>[
              Stack(
                children: [
                  Container(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        maxLength: 50,
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
                            labelStyle: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.black,
                        validator: validatetName,
                        onSaved: (value) {
                          _name = value;
                        },
                        maxLength: 80,
                        keyboardType: TextInputType.text,
                        controller: _desccontroller,
                        decoration: InputDecoration(
                          labelText: "Add store decription",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          border:
                              Border.all(color: Colors.lightGreen, width: 2)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Store Category",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Times new Roman"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(width: 20.0),
                                        DropdownButton(
                                          items: categoryItems,
                                          onChanged: (categoryValue) {
                                            setState(() {
                                              selected_value = categoryValue;
                                            });

                                            setState(() {
                                              selectedCategory = categoryValue;
                                            });
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
                      if (_formKey.currentState.validate()) {
                        setState(
                          () {
                            _sending = true;
                          },
                        );
                        storeData();
                        setState(
                          () {
                            _sending = true;
                          },
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StorecreatedPage(),
                          ),
                        );
                      }
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
      ),
    );
  }
}

String validatetName(String value) {
  _formKey.currentState.save();
  if (value.isEmpty)
    return 'This field should not be empty!!!';
  else
    return null;
}
