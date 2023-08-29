import '../utils/utility.dart';
import 'data_header.dart';

class LocalCuisine{
  bool _spicy = false;
  bool tasty = false;
  bool _sour = false;
  String _meal_type = '';
  String _meal = '';
  //for network data handling
  DataHeader _dataHeader = new DataHeader();

  LocalCuisine();

  LocalCuisine.fromJsonApi(var json){
    this._dataHeader = DataHeader.fromJsonApi(json);
    if(this._dataHeader.dataValidity()){
      this._spicy = json['data']['spicy'];
      this.tasty = json['data']['tasty'];
      this._sour = json['data']['sour'];
      this._meal_type = json['data']['meal-type'];
      this._meal = json['data']['meal'];
    }
  }

  Map<String, dynamic> getApiMapper() => {
    "spicy": spicy,
    "tasty": tasty,
    "sour": sour,
    "meal-type": meal_type,
  };

  DataHeader get dataHeader => _dataHeader;

  set dataHeader(DataHeader value) {
    _dataHeader = value;
  }

  String get meal => _meal;

  set meal(String value) {
    _meal = value;
  }

  String get meal_type => _meal_type;

  set meal_type(String value) {
    _meal_type = value;
  }

  bool get sour => _sour;

  set sour(bool value) {
    _sour = value;
  }

  bool get spicy => _spicy;

  set spicy(bool value) {
    _spicy = value;
  }
}