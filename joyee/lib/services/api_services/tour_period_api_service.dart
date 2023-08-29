import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:joyee/model/tour_period.dart';

import '../../utils/custom_widgets/toastMessage.dart';
import '../../utils/utility.dart';

class TourPeriodApiService{
  static final String _tourPeriodServerName = 'IT20475772';

  Future<TourPeriod> getLocalCuisine(TourPeriod tourPeriod) async {
    late TourPeriod responseTourPeriod = new TourPeriod();
    var url = Uri.parse('http://'+_tourPeriodServerName+ '.pythonanywhere.com/tour_period_analyzer/');
    //encode Map to JSON

    Map data = tourPeriod.getApiMapper();
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
        responseTourPeriod = TourPeriod.fromJsonApi(decodedBody);

      }else{
        ToastMessage.showErrorToast("Error Occurred while Retrieving  data. Please Try again");
      }

    } on Exception catch(ignoredException){
      ToastMessage.showErrorToast("Error Occurred while Retrieving data. Please Try again");
    }

    return responseTourPeriod;
  }
}