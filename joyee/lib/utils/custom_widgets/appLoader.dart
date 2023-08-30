import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class AppLoader{
   static Container popupLoader(Size size){
    return Container(
      padding: EdgeInsets.all(16),
      height: size.height * 0.5,
      width: size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitFadingCircle(
                color: THEME_COLOR,
                size: 100.0,
              ),
            ],
          ),
          Image.asset(APP_LOGO_COVER_PATH),
          SizedBox(height: 20),
          RichText(
            maxLines: null,
            textAlign: TextAlign.center,

            text: TextSpan(
              text: "JOYEE is analysing your Data. \n Please wait!... ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05, color: COLOR_BLACK),

            ),
          ),

        ],
      ),
    );
  }
}