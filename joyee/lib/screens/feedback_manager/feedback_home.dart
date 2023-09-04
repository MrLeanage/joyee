import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:joyee/model/feedback_rating.dart';
import 'package:joyee/services/api_services/feedback_rating_api_service.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/appLoader.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../utils/custom_widgets/FormField.dart';

class Feedback_Home extends KFDrawerContent {
  Feedback_Home({
    Key? key,
  });

  @override
  _Feedback_Home_State createState() => _Feedback_Home_State();
}

class _Feedback_Home_State extends State<Feedback_Home> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Define TextEditingController for the text fields
  final TextEditingController countryController = TextEditingController();
  final TextEditingController destinationHotelController = TextEditingController();
  final TextEditingController feedbackHotelController = TextEditingController();
  bool isLoading = false;
  var responseFeedbackRating = new FeedbackRating();

  generateFeedbackRating(Size size) async {
    setState(() => isLoading = true);
    SmartDialog.showLoading(
        widget: AppLoader.popupLoader(size)
    );
    FeedbackRating feedbackRating = new FeedbackRating();
    feedbackRating.country = countryController.text;
    feedbackRating.hotel_destination = destinationHotelController.text;
    feedbackRating.feedback = feedbackHotelController.text;

    FeedbackApiService _apiService = new FeedbackApiService();

    responseFeedbackRating = await _apiService.getFeedbackRating(feedbackRating).whenComplete(() =>
    setState(() {
      isLoading = false;
      SmartDialog.dismiss();
      print('error : '+ responseFeedbackRating.dataHeader.error.toString());
      if(!responseFeedbackRating.dataHeader.error){
        print('rate :' + responseFeedbackRating.analyzed_rating.toString());
        alertMessage(responseFeedbackRating, size);
      }
    })
    );


  }

  void alertMessage(FeedbackRating responseFeedbackRating, Size size){
    Alert(
        context: context,
        title: "FEEDBACK ANALYZER",
        desc: 'According to the feedback you have given for the ' +responseFeedbackRating.hotel_destination + ', we have analysed your all your emotions, thoughts from the text you provided as a feedback '
            + '. Analysed matching rating for your feedback is : ' +  responseFeedbackRating.analyzed_rating.toString() + '/ 5.0  ',
        style: AlertStyle(
          titleStyle: TextStyle(color: COLOR_BLUE, fontSize: size.width*0.05),
          descStyle: TextStyle(color: COLOR_BLACK, fontSize:  size.width*0.04),

        ),
        buttons: [
          DialogButton(
            // onPressed: () => Navigator.pop(context),
            onPressed: () =>{
              Navigator.pop(context)
            },

            child: Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            color: COLOR_YELLOW,
            // gradient: LinearGradient(colors: [
            //   COLOR_GREEN,
            //   COLOR_YELLOW
            // ]),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(APP_BACKGROUND_2_PATH), // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        child: Material(
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onPressed: widget.onMenuPressed,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(APP_AVATAR_PATH),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  APP_LOGO_COVER_PATH,
                                  width: size.width * 0.90,
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            Text("USER EXPERIENCE FEEDBACK MANAGER", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                            SizedBox(height: 25),
                            Container(
                              width: size.width,
                              padding: EdgeInsets.all(10),
                              color: Colors.amberAccent,
                              child: Text("Transforming Feedback into Ratings: Your Voice, Your Ratings!"
                                , style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: TEXT_BACKGROUND_COLOR,
                              child: Text("Text Insights Transformed: Unleash the Potential of Feedback Analysis! Our specialized plugin delves deep into textual feedback, unraveling sentiments and opinions to generate insightful ratings. Elevate your user engagement by harnessing the power of text analysis, converting words into valuable ratings that drive informed decisions. Let expressions shape the success of your venture!"
                                , style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                ),),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: countryController,
                              decoration: customInputDecoration('Enter Country :', size, null),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Country!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: destinationHotelController,
                              decoration: customInputDecoration( 'Enter Your Destination Hotel :', size, null),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please end Your Destination hotel!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: feedbackHotelController,
                              decoration: customInputDecoration( 'Enter Feedback :', size, null),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please add your Feedback for provided Hotel !';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      generateFeedbackRating(size);
                                    }
                                  },
                                  child: Text('Generate Feedback rating'),
                                  style: ElevatedButton.styleFrom(primary: COLOR_BLUE),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    countryController.clear();
                                    destinationHotelController.clear();
                                  },
                                  child: Text('Clear'),
                                  style: ElevatedButton.styleFrom(primary: COLOR_YELLOW),
                                ),
                              ],
                            ),

                            // Text("Stats", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                          ],
                        ),

                      )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
