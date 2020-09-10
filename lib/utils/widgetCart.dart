import 'package:flutter/material.dart';

TextStyle textStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 20,
  );
}

TextStyle pageStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.redAccent[200],
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
  );
}

BoxDecoration myBox2Decoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.teal[200],
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
  );
}
