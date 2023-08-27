import 'package:flutter/material.dart';
import 'package:joyee/utils/constants.dart';
import 'package:kf_drawer/kf_drawer.dart';

class Tour_Period_Home extends KFDrawerContent {
  Tour_Period_Home({
    Key? key,
  });

  @override
  _Tour_Period_HomeState createState() => _Tour_Period_HomeState();
}

class _Tour_Period_HomeState extends State<Tour_Period_Home> {

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
                      child: Text(" JOYEE is a Mobile App based enhanced features for promote SL tourism"
                          , style: TextStyle(
                            color: Colors.black,
                          fontSize: 16
                        ),),
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
