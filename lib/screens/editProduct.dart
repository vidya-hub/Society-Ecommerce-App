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
import 'package:society/screens/screen16.dart';
import 'package:society/screens/welcome.dart';
import 'package:uuid/uuid.dart';

class EditProductScreen extends StatefulWidget {
  String productId;
  EditProductScreen({this.productId});
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

final StorageReference storageRef = FirebaseStorage.instance.ref();

class _EditProductScreenState extends State<EditProductScreen> {
  String _name;
  File _image;
  final picker = ImagePicker();
  String postId = Uuid().v4();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  FirebaseUser log_user;

  String storeName = "";

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
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

  // Update Data in Product Collection
  updatePostInFirestore(
      {String mediaUrl,
      String title,
      String description,
      String price,
      String mobileNo}) {
    DocumentReference documentReference = Firestore.instance
        .collection('Product')
        .document(currentgoogleuserid)
        .collection('products')
        .document(widget.productId);
    var addDt = DateTime.now();
    var newFormat = DateFormat("dd-MMMM-y");

    documentReference.updateData(
      {
        'productPhotoUrl': mediaUrl,
        'productName': title,
        'productPrice': price,
        'productDescription': description,
        'updatedAt': newFormat.format(addDt),
      },
    );
  }

  @override
  void initState() {
    setStoreName();
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
    // setState(() {
    //   get_user();
    // });
    super.initState();
  }


  void setStoreName() async {
    var data = await Firestore.instance
        .collection("AddStore")
        .document(currentgoogleuserid)
        .get();
    setState(() {
      storeName = data.data["storeName"];
      print(storeName);
    });
  }

  bool _storing = false;
  @override
  Widget build(BuildContext context) {
    productSave() async {
      await compressImage();

      String mediaUrl = await uploadImage(_image);

      updatePostInFirestore(
        mediaUrl: mediaUrl,
        title: _nameController.text,
        description: _descController.text,
        price: _priceController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen16(
              widget.productId,
              mediaUrl,
              _nameController.text,
              _descController.text,
              _priceController.text),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: _storing,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(6),
            child: Column(children: <Widget>[
              Stack(
                children: [
                  Container(
                    // padding: EdgeInsets.only(top: 6.0),

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
                                  'Add a new Product image',
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
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    "$storeName",
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
                    controller: _descController,
                    decoration: InputDecoration(
                        // icon: Icon(Icons.people, color: Colors.black),
                        labelText: "Write description about the product",
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    validator: validatetName,
                    onSaved: (value) {
                      _name = value;
                    },
                    keyboardType: TextInputType.text,
                    controller: _priceController,
                    decoration: InputDecoration(
                        // icon: Icon(Icons.people, color: Colors.black),
                        labelText: "Price",
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              )),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  //color: Colors.black,
                  color: Color.fromRGBO(1, 44, 50, 0.8),
                  onPressed: () {
                    setState(() {
                      _storing = true;
                    });
                    productSave();
                    setState(() {
                      _storing = true;
                    });
                  },
                  child: Text(
                    'EDIT PRODUCT IN STORE',
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
}

String validatetName(String value) {
  if (value.isEmpty)
    return 'Name Should not be empty!!!';
  else
    return null;
}
