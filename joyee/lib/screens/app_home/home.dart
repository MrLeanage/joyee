import 'package:flutter/material.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../cuisine_manager/cusine_home.dart';
import '../feedback_manager/feedback_home.dart';
import '../period_manager/tour_period_home.dart';
import '../travel_manager/travel_mode_home.dart';

class Home extends KFDrawerContent {
  Home({
    Key? key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> listOfNavigationMap = [
    {
      "page-id" : "tour_page",
      "img-path": TOUR_PERIOD_IMAGE,
      "title": "Tour Period Analyzer",
      "color-code" : "#ffbc07",
    },
    {
      "page-id" : "cuisine_page",
      "img-path": CUISINE_DISCOVERY_IMAGE,
      "title": "Regional Cuisine Discovery",
      "color-code" : "#0e609a",
    },
    {
      "page-id" : "travel_page",
      "img-path": TRAVEL_MODE_IMAGE,
      "title": "Travel Mode Analyzer",
      "color-code" : "#0e609a",
    },
    {
      "page-id" : "ux_page",
      "img-path": USER_EXPERIENCE_IMAGE,
      "title": "UX Feedback Manager",
      "color-code" : "#ffbc07",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: <Widget>[
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
                        Text("WELCOME TO " + APP_NAME, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: TEXT_BACKGROUND_COLOR,
                          child: Text(
                            "Experience the world with " + APP_NAME + ", your ultimate travel companion app. Explore the rich features of our plugins, each designed to enhance your travel journey.",
                            style: TextStyle(
                                fontSize: 16,

                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                            height: 400,
                            width: double.infinity,

                            child:  GridView.builder(

                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 columns
                              ),
                              itemCount: 4, // Number of containers you want to display
                              itemBuilder: (BuildContext context, int index) {
                                // You can customize the content of each container here

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: homeNavWidget(listOfNavigationMap[index], size),
                                ); // Replace with your original Container code
                              },
                            ),
                        ),
                        SizedBox(height: 15),
                        Text( APP_NAME + " APP SIMULATION", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                        SizedBox(height: 15),
                        Container(

                          decoration: BoxDecoration(
                              color: Colors.amberAccent[100],
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Welcome to " + APP_NAME + ", your go-to travel app! Let's embark on an exciting virtual journey together. " + APP_NAME + " is your all-in-one travel companion, introducing you to a world of possibilities. Explore the globe smarter with our plugins: 'Tour Period Analyzer' for trip planning, 'Regional Cuisine Discovery' for food adventures, 'Travel Mode Analyzer' for customized journeys, and 'UX Feedback Manager' to share your thoughts. " + APP_NAME + " is here to make your travels unforgettable.",
                            style: TextStyle(
                              fontSize: 16,

                            ),
                            textAlign: TextAlign.justify,
                          ),

                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Container(
                              height: size.height * 0.1,
                              width: size.width * 0.9,
                              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
                              // color: Colors.redAccent,
                              child: ElevatedButton(
                                onPressed: () =>{
                                  ToastMessage.showErrorToast("This Feature Not Enabled Yet")
                                },
                                child: Wrap(children : [
                                  Icon(
                                    Icons.not_started_outlined,
                                    color: COLOR_WHITE,
                                  ),
                                  SizedBox(width: 20,),
                                  Text(
                                    'START' + APP_NAME + 'SIMULATION',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  )
                                ],),
                                style: ElevatedButton.styleFrom(
                                  primary: THEME_COLOR,
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: 30),
                        // Text("Stats", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]
      ),
    );
  }
  Widget homeNavWidget(Map listOfNavigationMapItem, Size windowsSize){
    String pageId = listOfNavigationMapItem['page-id'];
    String imgPath = listOfNavigationMapItem['img-path'];
    String title = listOfNavigationMapItem['title'];
    String hexColorCode = listOfNavigationMapItem['color-code'];
    Color dynamicColor = Color(int.parse(hexColorCode.substring(1, 7), radix: 16) + 0xFF000000);
    return InkWell(

      onTap: (){
        if(pageId == 'tour_page'){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Tour_Period_Home())
          );
        }else if(pageId == 'cuisine_page'){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>  Cuisine_Home())
          );
        } else if(pageId == 'travel_page'){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Travel_Mode_Home())
          );
        }else if(pageId == 'ux_page'){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Feedback_Home())
          );
        }

      },
      child: Container(
        width: 150,
        height: 150,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // border: Border.all(color: COLOR_BROWN),
            color: Colors.grey[300]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: windowsSize.width * 0.2,
                width: windowsSize.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                  ),
                )
            ),
            SizedBox(height: 10,),
            Container(
              // color: Colors.white,
              width: windowsSize.width * 0.5,
              height: 50,
              decoration: BoxDecoration(
                  color: dynamicColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft : Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 5),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: windowsSize.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // Text overflow behavior
                    maxLines: 2,
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
