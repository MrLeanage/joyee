import '../utils/utility.dart';

class DataHeader{
  //for network data handling
  int _status = 0;
  String _date = '';
  String _time = '';
  bool _error = false;
  String _errorMessage = '';

  DataHeader();
  DataHeader.fromJsonApi(var json){
    this._error = json['error'];
    var dateTime = Utility.getDateAndTimeFromTimestamp(json['time-stamp']);
    this._time = dateTime['time']!;
    this._date =  dateTime['date']!;
    this._status =  json['time-stamp'];

    if(!dataValidity()){
      Utility.showApiResponseErrorToast();
    }
  }

  bool dataValidity (){
    return this._status == 200 && !this._error ? true : false;
  }

  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
  }

  bool get error => _error;

  set error(bool value) {
    _error = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }
}