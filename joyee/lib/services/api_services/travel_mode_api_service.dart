import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:joyee/model/travel_mode.dart';

import '../../utils/custom_widgets/toastMessage.dart';
import '../../utils/utility.dart';

class TravelModeApiService{
  static final String _travelModeServerName = 'it20300678';

  Future<TravelMode> getTravelMode(TravelMode travelMode) async {
    late TravelMode responseTravelMode = new TravelMode();
    var url = Uri.parse('http://'+_travelModeServerName+ '.pythonanywhere.com/travel_mode_analyzer/');
    //encode Map to JSON

    Map data = travelMode.getApiMapper();
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
        responseTravelMode = TravelMode.fromJsonApi(decodedBody);

      }else{
        ToastMessage.showErrorToast("Error Occurred while Retrieving  data. Please Try again");
      }

    } on Exception catch(ignoredException){
      ToastMessage.showErrorToast("Error Occurred while Retrieving data. Please Try again");
    }

    return responseTravelMode;
  }
}