import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:joyee/utils/constants.dart';

import 'addSpace_widget.dart';
import 'base_widget.dart';

class Loader extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    final double padding = 10;
    final sidePadding = EdgeInsets.symmetric(horizontal: 10);
    return Scaffold(
      body: BaseWidget(
        child: Container(

            decoration: BoxDecoration(
              //   gradient:LinearGradient(
              //       colors: [
              //         COLOR_BROWN,
              //         COLOR_BROWN_LIGHT1
              //       ],
              //       begin: const FractionalOffset(0.4, 0.0),
              //       end: const FractionalOffset(1.0, 0.0),
              //       stops: [0.0, 1.0],
              //       tileMode: TileMode.clamp),
              image: DecorationImage(
                image: AssetImage(APP_BACKGROUND_PATH),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
              ),
            ),
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(size.height*0.2),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        ],

                      ),
                    ),
                    addVerticalSpace(padding),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SpinKitFadingCircle(
                          color: THEME_COLOR,
                          size: 90.0,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                        height: size.height* 0.2,
                        child: Image.asset(APP_LOGO_COVER_PATH)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                              'Loading Please Wait..',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ],
            )
        ),
      )
    );
  }
}