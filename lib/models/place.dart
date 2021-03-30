import 'package:flutter/cupertino.dart';

class SelectPlace {
  SelectPlace(
      {@required this.allLocation,
  @required this.city,
  @required this.district,
  @required this.no,
  @required this.postCode,
  @required  this.street,
  @required this.longitude,
  @required this.latitude});

  ///record the all street name of this place. ex. 236台灣新北市土城區明峰街41號
  final String allLocation;

  /// record the city name. ex. New Taipei City
  final String city;

  ///record the district name. ex. TaiShang Distirct.
  final String district;

  ///record the street name. ex. MinFung Street
  final String street;

  /// record the number. ex. 41
  final String no;

  ///record the postCode. ex.236
  final String postCode;

  ///record the latitude. ex.22.32645
  final double latitude;

  ///record the longitude. ex.121.2326613
  final double longitude;
}
