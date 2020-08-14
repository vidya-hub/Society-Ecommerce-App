import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods_store {

  getData() async {
    return await Firestore.instance.collection("AddStore").snapshots();
  }
}

// class CrudMethods_product{

// }