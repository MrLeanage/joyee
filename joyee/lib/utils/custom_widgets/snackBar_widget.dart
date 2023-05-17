import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';
import 'package:overlay_support/overlay_support.dart';


class CustomSnackBar{
  static void showTopSnackBar(
      BuildContext context,String title, String message, Color color
      ) => showSimpleNotification(
            Text(title),
            subtitle: Text(message),
            background: color,
  );

  static void showErrorTopSnackBar(
      BuildContext context,String title, String message
      ) => showSimpleNotification(
    Text(title),
    subtitle: Text(message),
    background: Colors.red[300],
  );

  static SnackBar  showErrorSnack(String message){
    return SnackBar(
      content: Text(
        // "Please Attach Images of your pet's diseased area before tap on UPLOAD IMAGES",
          message,
        style: TextStyle(
            fontSize: 15
        ),
      ),

      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left : 50, bottom: 150.0, right: 50),
      elevation: 100,
      backgroundColor: Colors.red[400],
      duration: Duration(seconds: 5),


    );
  }

  static SnackBar  showSuccessSnack(String message){
    return SnackBar(
      content: Text(
        // "Please Attach Images of your pet's diseased area before tap on UPLOAD IMAGES",
        message,
        style: TextStyle(
            fontSize: 15
        ),
      ),

      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left : 50, bottom: 150.0, right: 50),
      elevation: 100,
      backgroundColor: Colors.green[400],
      duration: Duration(seconds: 5),


    );
  }

  static SnackBar  showNetworkFailureSnack(BuildContext context){
    double height =  context.size!.height;
    return SnackBar(
      content: Text(
        // "Please Attach Images of your pet's diseased area before tap on UPLOAD IMAGES",
        "Device is Not Connected to Internet",
        style: TextStyle(
            fontSize: 15
        ),
      ),

      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left : 50, bottom: height * 0.85, right: 50),
      elevation: 100,
      backgroundColor: Colors.redAccent[200],
      duration: Duration(seconds: 5),


    );
  }
}