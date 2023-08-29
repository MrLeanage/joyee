import 'package:joyee/utils/custom_widgets/toastMessage.dart';

import '../utils/utility.dart';
import 'data_header.dart';

class TourPeriod{
  String _country = '';

  //for network data handling
  DataHeader _dataHeader = new DataHeader();

  TourPeriod();

  TourPeriod.fromJsonApi(var json){
    this._dataHeader = DataHeader.fromJsonApi(json);
    if(this._dataHeader.dataValidity()){
      this._country = json['data']['country'];
    }
  }

  Map<String, dynamic> getApiMapper() => {
    "country": country
  };

  DataHeader get dataHeader => _dataHeader;

  set dataHeader(DataHeader value) {
    _dataHeader = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }
}