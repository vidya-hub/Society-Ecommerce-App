import 'package:flutter/foundation.dart';

class SocietyModel {
  final String id;
  final String societyname;
  final String address;
  final String city;
  final String state;

  SocietyModel({
    @required this.id,
    @required this.societyname,
    @required this.address,
    @required this.city,
    @required this.state,
  });
}

class Society with ChangeNotifier {
  List<SocietyModel> _societyList = [];
  List<SocietyModel> get societyList {
    return [..._societyList];
  }

  int get itemSocietyCount {
    return _societyList.length;
  }

  void addSociety(String id, String societyname, String address, String city,
      String state) {
    _societyList.add(SocietyModel(
        id: id,
        societyname: societyname,
        address: address,
        city: city,
        state: state));
  }
}
