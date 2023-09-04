import 'dart:convert';

import 'package:joyee/model/local_cuisine.dart';
import 'package:http/http.dart' as http;

import '../../utils/custom_widgets/toastMessage.dart';
import '../../utils/utility.dart';

class LocalCuisineApiService{
  static final String _localCuisineServerName = 'it20479114';

  Future<LocalCuisine> getLocalCuisine(LocalCuisine localCuisine) async {
    late LocalCuisine responseLocalCuisine = new LocalCuisine();
    var url = Uri.parse('http://'+_localCuisineServerName+ '.pythonanywhere.com/local_cuisine_analyzer/');
    
    //encode Map to JSON
    Map data = localCuisine.getApiMapper();
    print(localCuisine.getApiMapper());
    //encode Map to JSON
    var body = json.encode(data);

    try{
      //setting  api call timeout
      Utility.activateApiTimeout();
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: body
      );
      if(response.statusCode == 200){
        var decodedBody = json.decode(response.body);
        responseLocalCuisine = LocalCuisine.fromJsonApi(decodedBody);

      }else{
        ToastMessage.showErrorToast("Error Occurred while Retrieving  data. Please Try again");
      }
    } on Exception catch(ignoredException){
      ToastMessage.showErrorToast("Error Occurred while Retrieving data. Please Try again");
    }

    return responseLocalCuisine;
  }
}