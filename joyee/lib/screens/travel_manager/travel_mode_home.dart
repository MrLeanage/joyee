import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:joyee/model/tour_period.dart';
import 'package:joyee/model/travel_mode.dart';
import 'package:joyee/services/api_services/feedback_rating_api_service.dart';
import 'package:joyee/services/api_services/local_cuisine_api_service.dart';
import 'package:joyee/services/api_services/tour_period_api_service.dart';
import 'package:joyee/services/api_services/travel_mode_api_service.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/appLoader.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../utils/custom_widgets/FormField.dart';

class Travel_Mode_Home extends KFDrawerContent {
  Travel_Mode_Home({
    Key? key,
  });

  @override
  _Travel_Mode_Home_State createState() => _Travel_Mode_Home_State();
}

class _Travel_Mode_Home_State extends State<Travel_Mode_Home> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Define TextEditingController for the text fields
  final TextEditingController startDestinationController = TextEditingController();
  final TextEditingController endDestinationController = TextEditingController();
  bool isLoading = false;

  findTourPeriod(Size size) async {
    setState(() => isLoading = true);
    SmartDialog.showLoading(
        widget: AppLoader.popupLoader(size)
    );
    TravelMode travelMode = new TravelMode();
    travelMode.startDestination = startDestinationController.text;
    travelMode.endDestination = endDestinationController.text;

    TravelModeApiService _apiService = new TravelModeApiService();
    TravelMode responseTourMode = await _apiService.getTravelMode(travelMode);

    setState(() {
      isLoading = false;
      SmartDialog.dismiss();
      alertMessage(responseTourMode, size);
    });
  }

  void alertMessage(TravelMode responseTourMode, Size size){
    Alert(
        context: context,
        title: "TRAVEL MODE ANALYZER",
        desc: 'Many of visitors has preferred ' +responseTourMode.mode + ' as their transportation mode for visit ' + responseTourMode.endDestination + ' from ' + responseTourMode.startDestination,
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
      child: ListView(
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
                      Text("TRAVELING MODE MANAGER", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                      SizedBox(height: 25),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(10),
                        color: Colors.amberAccent,
                        child: Text("Explore the best ways to travel around Sri Lanka"
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
                        child: Text("Discover the ideal way to traverse Sri Lanka's enchanting landscapes. Embrace the scenic charm aboard iconic blue trains, unwind in budget-friendly buses, or relish personalized taxi journeys. For immersive experiences, opt for tuk-tuks or cycling through bustling streets. With diverse options that blend tradition and modernity, uncover the beauty and culture of Sri Lanka through its vibrant transportation modes."
                          , style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: startDestinationController,
                        decoration: customInputDecoration('Enter Start Destination :', size, null),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Your Start Destination!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: endDestinationController,
                        decoration: customInputDecoration('Enter End Destination :', size, null),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Your End Destination!';
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
                               findTourPeriod(size);
                              }
                            },
                            child: Text('Find Preferred Travel Mode'),
                            style: ElevatedButton.styleFrom(primary: COLOR_BLUE),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              startDestinationController.clear();
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
    );
  }

  Widget listItem(String imgPath, String title){
    return InkWell(
      onTap: (){
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
            // border: Border.all(color: COLOR_BROWN),
          color: Colors.grey[300]
        ),
        child: Column(
          children: [
            Container(
              // color: Colors.white,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft : Radius.circular(10))
              ),
              child: Row(
                children: [
                  Text(
                      title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage(imgPath),
                      fit: BoxFit.cover
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget listItemStats(String imgPath, String name, bool value){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: value == true ? Colors.white : Color.fromRGBO(75, 97, 88, 1.0)
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Image(image: AssetImage(imgPath),width: 45,height: 45, color: value == true ? Colors.black : Colors.white),
          SizedBox(height: 15),
          Text(name, style: TextStyle(fontSize: 13, color: value == true ? Colors.black : Colors.white)),
          SizedBox(height: 5),
          Switch(
            value: value,
            onChanged: (newVal){
              setState(() {
                value = newVal;
                print(newVal);
              });
            },
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
