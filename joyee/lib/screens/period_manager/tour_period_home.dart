import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:joyee/services/api_services/local_cuisine_api_service.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/appLoader.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../model/tour_period.dart';
import '../../services/api_services/tour_period_api_service.dart';
import '../../utils/custom_widgets/FormField.dart';

class Tour_Period_Home extends KFDrawerContent {
  Tour_Period_Home({
    Key? key,
  });

  @override
  _Tour_Period_Home_State createState() => _Tour_Period_Home_State();
}

class _Tour_Period_Home_State extends State<Tour_Period_Home> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Define TextEditingController for the text fields
  final TextEditingController countryController = TextEditingController();
  bool isLoading = false;

  findTourPeriod(Size size) async {
    setState(() => isLoading = true);
    SmartDialog.showLoading(
        widget: AppLoader.popupLoader(size)
    );
    TourPeriod tourPeriod = new TourPeriod();
    tourPeriod.country = countryController.text;

    TourPeriodApiService _apiService = new TourPeriodApiService();
    TourPeriod responseTourPeriod = await _apiService.getLocalCuisine(tourPeriod);

    setState(() {
      isLoading = false;
      SmartDialog.dismiss();
      if(!responseTourPeriod.dataHeader.error){
        alertMessage(responseTourPeriod, size);
      }
    });
  }

  void alertMessage(TourPeriod responseTourPeriod, Size size){
    Alert(
        context: context,
        title: "TOUR PERIOD ANALYZER",
        desc: 'Many of from your country has visited Sri Lanka in the Month of ' +responseTourPeriod.month,
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
                        Text("TOUR PERIOD MANAGER", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                        SizedBox(height: 25),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.all(10),
                          color: Colors.amberAccent,
                          child: Text("Discover the perfect time to explore Sri Lanka "
                            , style: TextStyle(
                                color: Colors.black,
                                fontSize: 16
                            ),),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: TEXT_BACKGROUND_COLOR,
                          child: Text("Embark on an unforgettable journey to Sri Lanka! Our app helps you choose the perfect time to visit this tropical haven. Whether you're dreaming of sun-soaked beaches, lush landscapes, or vibrant festivals, we've got you covered. Explore the diverse attractions and activities this gem of an island offers, all tailored to the best times for your ultimate adventure."
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
                              return 'Please enter country!';
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
                              child: Text('Find Tour Period'),
                              style: ElevatedButton.styleFrom(primary: COLOR_BLUE),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                countryController.clear();
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
