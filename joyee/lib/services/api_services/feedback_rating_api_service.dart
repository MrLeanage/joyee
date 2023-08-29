import 'dart:convert';

import 'package:joyee/model/feedback_rating.dart';
import 'package:http/http.dart' as http;
import 'package:joyee/utils/utility.dart';

import '../../utils/custom_widgets/toastMessage.dart';

class TravelModeApiService{
  static final String _feedbackRatingServerName = 'it19099200';

  Future<FeedbackRating> getFeedbackRating(FeedbackRating feedbackRating) async {
    late FeedbackRating responseFeedbackRating = new FeedbackRating();
    var url = Uri.parse('http://'+_feedbackRatingServerName+ '.pythonanywhere.com/feedback_rating_analyzer/');
    //encode Map to JSON

    Map data = feedbackRating.getApiMapper();
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
        responseFeedbackRating = FeedbackRating.fromJsonApi(decodedBody);

      }else{
        ToastMessage.showErrorToast("Error Occurred while Retrieving  data. Please Try again");
      }

    } on Exception catch(ignoredException){
      ToastMessage.showErrorToast("Error Occurred while Retrieving data. Please Try again");
    }

    return responseFeedbackRating;
  }
}