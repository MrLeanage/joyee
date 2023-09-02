import 'dart:ffi';

import 'data_header.dart';

class FeedbackRating{
  String _feedback = '';
  String _country = '';
  String _hotel_destination = '';
  double _analyzed_rating = 0.0;

  //for network data handling
  DataHeader _dataHeader = new DataHeader();

  FeedbackRating();

  FeedbackRating.fromJsonApi(var json){
    this._dataHeader = DataHeader.fromJsonApi(json);
    if(this._dataHeader.dataValidity()){
      this._feedback = json['data']['feedback'];
      this._country = json['data']['country'];
      this._hotel_destination = json['data']['hotel-destination'];
      this._analyzed_rating = json['data']['rating'];
      print('model rate :' + json['data']['rating'].toString());
    }
  }

  Map<String, dynamic> getApiMapper() => {
    "feedback": feedback,
    "country": country,
    "hotel-destination": hotel_destination,
  };


  DataHeader get dataHeader => _dataHeader;

  set dataHeader(DataHeader value) {
    _dataHeader = value;
  }

  double get analyzed_rating => _analyzed_rating;

  set analyzed_rating(double value) {
    _analyzed_rating = value;
  }

  String get hotel_destination => _hotel_destination;

  set hotel_destination(String value) {
    _hotel_destination = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get feedback => _feedback;

  set feedback(String value) {
    _feedback = value;
  }
}