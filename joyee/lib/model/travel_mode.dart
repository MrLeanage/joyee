import '../utils/utility.dart';
import 'data_header.dart';

class TravelMode{
  String _startDestination = '';
  String _endDestination = '';
  String _mode = '';

  //for network data handling
  DataHeader _dataHeader = new DataHeader();

  TravelMode();

  TravelMode.fromJsonApi(var json){
    this._dataHeader = DataHeader.fromJsonApi(json);
    if(this._dataHeader.dataValidity()){
      this._startDestination = json['data']['start-destination'];
      this._endDestination = json['data']['end-destination'];
      this._mode = json['data']['mode'];
    }
  }

  Map<String, dynamic> getApiMapper() => {
    "start-destination" : startDestination,
    "end-destination" : endDestination
  };

  DataHeader get dataHeader => _dataHeader;

  set dataHeader(DataHeader value) {
    _dataHeader = value;
  }

  String get mode => _mode;

  set mode(String value) {
    _mode = value;
  }

  String get endDestination => _endDestination;

  set endDestination(String value) {
    _endDestination = value;
  }

  String get startDestination => _startDestination;

  set startDestination(String value) {
    _startDestination = value;
  }
}