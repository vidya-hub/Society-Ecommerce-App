import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import '../screens/screen13.dart';
import '../screens/screen16.dart';
import '../screens/welcome.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

final StorageReference storageRef = FirebaseStorage.instance.ref();
String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _AddProductScreenState extends State<AddProductScreen> {
  bool loading = false;
  String _name;
  File _image;
  String productID;
  final picker = ImagePicker();
  String postId = Uuid().v4();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  FirebaseUser log_user;

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img.Image imageFile = Img.decodeImage(_image.readAsBytesSync());

    final compressedImageFile = File('$path/img_$postId')
      ..writeAsBytesSync(Img.encodeJpg(imageFile, quality: 85));

    setState(() {
      _image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask = storageRef
        .child('products')
        .child('post_$postId.jpg')
        .putFile(imageFile);

    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;

    String downloadUrl = await storageSnap.ref.getDownloadURL();

    return downloadUrl;
  }

  // Store Data in Product Collection
  createPostInFirestore(
      {String mediaUrl,
      String title,
      String description,
      String price,
      String mobileNo}) {
    DocumentReference documentReference = Firestore.instance
        .collection('Product')
        .document(currentgoogleuserid)
        .collection('products')
        .document();
    var addDt = DateTime.now();
    var newFormat = DateFormat("dd-MMMM-y");
    setState(() {
      productID = documentReference.documentID;
      print('product id' + productID);
    });
    String productId = documentReference.documentID;

    documentReference.setData(
      {
        'createdAt': newFormat.format(addDt),
        'productPhotoUrl': mediaUrl,
        'productName': title,
        'productPrice': price,
        'productDescription': description,
        'productId': productId,
        'status': 'Out Of Stock',
        'updatedAt': '',
      },
    );
  }

  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id;
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

  bool _storing = false;
  @override
  Widget build(BuildContext context) {
    productSave() async {
      await compressImage();

      String mediaUrl = await uploadImage(_image);

      createPostInFirestore(
        mediaUrl: mediaUrl,
        title: _nameController.text,
        description: _descController.text,
        price: _priceController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Screen16(
                productID,
                mediaUrl,
                _nameController.text,
                _descController.text,
                _priceController.text)),
      );
    }

    return loading
        ? Center(
            child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  strokeWidth: 3,
                )))
        : Scaffold(
            resizeToAvoidBottomPadding: true,
            body: ModalProgressHUD(
              inAsyncCall: _storing,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Column(children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.50,
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
                                        'Add a Product image',
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
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              cursorColor: Colors.black,
                              validator: validatetName,
                              onSaved: (value) {
                                _name = value;
                              },
                              keyboardType: TextInputType.text,
                              controller: _nameController,
                              maxLength: 50,
                              decoration: InputDecoration(
                                  // icon: Icon(Icons.people, color: Colors.black),
                                  labelText: "Write Product Name",
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                              controller: _descController,
                              decoration: InputDecoration(
                                  // icon: Icon(Icons.people, color: Colors.black),
                                  labelText:
                                      "Write description about the product",
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              cursorColor: Colors.black,
                              validator: validatetName,
                              onSaved: (value) {
                                _name = value;
                              },
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              controller: _priceController,
                              decoration: InputDecoration(
                                // icon: Icon(Icons.people, color: Colors.black),
                                labelText: "Price",
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                    //Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        //color: Colors.black,
                        color: Color.fromRGBO(1, 44, 50, 0.8),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            loading = true;
                            setState(() {
                              _storing = true;
                            });
                            productSave();
                            setState(() {
                              _storing = false;
                            });
                          }
                        },
                        child: Text(
                          'ADD TO MY STORE',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
  }

  String validatetName(String value) {
    _formKey.currentState.save();
    if (value.isEmpty)
      return 'This field should not be empty!!!';
    else
      return null;
  }
}
