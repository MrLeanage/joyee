import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:joyee/model/local_cuisine.dart';
import 'package:joyee/services/api_services/local_cuisine_api_service.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/appLoader.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Cuisine_Home extends KFDrawerContent {
  Cuisine_Home({
    Key? key,
  });

  @override
  _Cuisine_Home_State createState() => _Cuisine_Home_State();
}

class _Cuisine_Home_State extends State<Cuisine_Home> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Define TextEditingController for the text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool isLoading = false;

  bool spicyToggle = false;
  bool tastyToggle = true;
  bool sourToggle = false;
  List<String> mealTypes = <String>['Breakfast', 'Lunch', 'Snack', 'Dinner'];
  String selectedValue = '';

  findLocalCuisine(Size size) async {

    LocalCuisine localCuisine = new LocalCuisine();
    localCuisine.spicy = spicyToggle;
    localCuisine.tasty = tastyToggle;
    localCuisine.sour = sourToggle;

    SmartDialog.showLoading(
        widget: AppLoader.popupLoader(size)
    );

    setState(() => isLoading = true);
    LocalCuisineApiService _apiService = new LocalCuisineApiService();
    LocalCuisine responseLocalCuisine = await _apiService.getLocalCuisine(localCuisine);


    setState(() {
      isLoading = false;
      SmartDialog.dismiss();
      if(responseLocalCuisine.dataHeader.error){
        alertMessage(responseLocalCuisine, size);
      }
    });
  }

  void alertMessage(LocalCuisine responseLocalCuisine, Size size){
    Alert(
        context: context,
        title: "LOCAL CUISINE ANALYZER",
        desc: 'We have analyzed your preferences and desired meal type. According to your selection, we found a cuisine named ' +responseLocalCuisine.meal + ' to try out',
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
    selectedValue = mealTypes.first;
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
                      Text("REGIONAL CUISINE DISCOVERY MANAGER", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                      SizedBox(height: 25),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(10),
                        color: Colors.amberAccent,
                        child: Text("Try out Yummy local food choices just for you!!"
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
                        child: Text("Discover the perfect culinary adventure for your taste buds with our curated selection of exquisite regional cuisines. From tantalizing flavors to authentic traditions, our mobile app helps you explore and savor the best in food culture Sri Lanka."
                          , style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Do you want to try Spicy Local Cuisine? :    '),
                          Switch(
                            value: spicyToggle,
                            onChanged: (newValue) {
                              setState(() {
                                spicyToggle = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Do you consider taste of Local Cuisine? :   '),
                          Switch(
                            value: tastyToggle,
                            onChanged: (newValue) {
                              setState(() {
                                tastyToggle = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Would you like to try sour Local Cuisine? :  ' ),
                          Switch(
                            value: sourToggle,
                            onChanged: (newValue) {
                              setState(() {
                                sourToggle = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Select Your Preferred Meal Type :'),
                          SizedBox(width: 10),
                          DropdownButton<String>(
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: mealTypes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                               findLocalCuisine(size);
                              }
                            },
                            child: Text('Find Local Cuisine'),
                            style: ElevatedButton.styleFrom(primary: COLOR_BLUE),
                          ),

                          // ElevatedButton(
                          //   onPressed: () {
                          //     alertMessage(new LocalCuisine(), size);
                          //   },
                          //   child: Text('Find Local Cuisine'),
                          //   style: ElevatedButton.styleFrom(primary: COLOR_YELLOW),
                          // ),
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
}
