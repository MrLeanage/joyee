import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';

InputDecoration customInputDecoration(String value, Size screenSize, var icon){
  return InputDecoration(
    // icon: new Icon(icon, color: COLOR_BROWN),

     prefixIcon: icon != null? Padding(
      padding: EdgeInsets.all(5), // add padding to adjust icon
      child: Icon(icon, color: THEME_COLOR),
    ) : null,

    isDense: false,
    labelText: value,
    labelStyle: TextStyle(
        fontSize: screenSize.width * 0.035
    ),

    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: THEME_COLOR,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: COLOR_RED,
        width: 1.0,
      ),
    ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: COLOR_BLUE,
          width: 1.0,
        ),
      )
  );
}

LinearGradient customHeaderLinearGradient(var firstColor, var secondColor){
  return LinearGradient(
      colors: [
        firstColor,
        secondColor
      ],
      begin: const FractionalOffset(0.4, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp
  );
}
Container customRatingBar(int userCount, int totalRate){
  double rate = totalRate / userCount;

  return Container(
    child: Column(


      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                'Ratings by users: '
            )
          ],

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                '($rate / 5.0) '
            )
          ],

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RatingBarIndicator(
              rating: rate,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 25.0,
              direction: Axis.horizontal,
            )
          ],

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                'From $userCount Users '
            )
          ],

        ),
      ],
    ),
  );
}
