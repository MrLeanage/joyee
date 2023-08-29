import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'custom_widgets/snackBar_widget.dart';

class Utility{

  Utility();

   static Future<bool> isConnectedToNetwork() async {
    bool isConnectedToInternet = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnectedToInternet = true;
        print('connected');
        // ToastMessage.showSuccessToast("Connected to Internet");
        CustomSnackBar.showSuccessSnack( "Connected to Internet");
      }
    } on SocketException catch (_) {
      print('not connected');
      // ToastMessage.showErrorToast("Not Connected to Internet");
      CustomSnackBar.showErrorSnack( "Not Connected to Internet");    }

    // final color = isConnectedToInternet ? COLOR_GREEN : COLOR_RED;
    // CustomSnackBar.showTopSnackBar(context, 'Internet Connectivity Status', message, color);

    return isConnectedToInternet;
  }

  static showConnectivitySnackBar(ConnectivityResult result, BuildContext context){
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no Internet';
    final color = hasInternet ? COLOR_GREEN : COLOR_RED;
    CustomSnackBar.showTopSnackBar(context, 'Internet Connectivity Status', message, color);
    //SnackBar.showTopSnackBar(context, msg, color);
  }


  String formatCurrency(num amount, {int decimalCount = 0}){
    final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: decimalCount);
    return formatCurrency.format(amount);
  }
  
  static List<String> listBuilderFromJson(var jsonList){
    List<String> list = [];
    for(var json in jsonList){
      list.add(json.toString());
    }
    return list;
  }

  static String convertTimeStampToDate(var json){
    String formatDate = "Not Available";
    //int seconds = 1631290360;
    int constant = 1000;

      // try{
      //   seconds = json['seconds'];
      //   seconds = json['seconds'];
      // }catch(Exception){
      //   Exception.toString();
      // }
      if(json != null){
        if(json['_seconds'] != 0){
          print("Key  contain");
          print("dates :"+ json['_seconds'].toString());
          int seconds = json['_seconds'].toInt();
          DateTime date = DateTime.fromMillisecondsSinceEpoch( (seconds * constant).toInt());
          formatDate = DateFormat('yyyy-MM-dd').format(date);
          print("dates : "+ formatDate);
        }else{
          print("dates :"+ json['seconds'].toString());
          print("Key available Seconds not available");
        }
      }else{
        print("Key not contain");
      }

      // print("value : "+(seconds*constant).toString() );




    // try{
    //
    // }catch(Exception){
    //   formatDate = "Not Available";
    // }
    return formatDate;
  }

  static List<String> covertParagraphToArray(String paragraph){
    List<String> listArray = paragraph.split('. ');

    return listArray;
  }

  static Size getContainerSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  }


  //Snack Bars

  static void showErrorSnack(String errorMessage, BuildContext context){
    final snackBar = CustomSnackBar.showErrorSnack(errorMessage);
    //
    // // Find the ScaffoldMessenger in the widget tree
    // // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<bool> validateAppInternetConnection(BuildContext context) async{

    if(!await isConnectedToNetwork()){
      final snackBar = CustomSnackBar.showNetworkFailureSnack(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    }else{
      return true;
    }
  }

  static Map<String, String> getDateAndTimeFromTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    String formattedDate = '${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}';
    String formattedTime = '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}';

    return {
      'date': formattedDate,
      'time': formattedTime,
    };
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  static void showApiResponseErrorToast(){
     ToastMessage.showErrorToast("Error Occurred while Retrieving Data. Please Try again");
  }
  
  static void activateApiTimeout(){
    Future.delayed(Duration(seconds: 20), () {
      ToastMessage.showErrorToast('Network Connection Timeout reached 20s');
    });
  }

}