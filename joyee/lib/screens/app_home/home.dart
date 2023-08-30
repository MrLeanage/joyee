import 'package:flutter/material.dart';
import 'package:joyee/utils/constants.dart';
import 'package:kf_drawer/kf_drawer.dart';

class Home extends KFDrawerContent {
  Home({
    Key? key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
}
