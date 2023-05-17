import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class AppLoader{
   static Container popupLoader(Size size){
    return Container(
      padding: EdgeInsets.all(16),
      height: 280,
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Column(
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
          Text(
            "HAPPY PET is analysing your pet'Data. Please wait!... ",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}