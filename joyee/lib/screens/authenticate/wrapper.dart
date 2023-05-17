import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joyee/screens/authenticate/authenticate.dart';
import 'package:joyee/utils/custom_widgets/loader_widget.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import '../app_home/AppBase_Screen.dart';

class Wrapper extends StatelessWidget {
  // Widget wraperPage() {
  //   return StreamBuilder<FirebaseUser>(
  //     stream: FirebaseAuth.instance.onAuthStateChanged,
  //     builder: (BuildContext context, snapshot) {
  //       if (snapshot.hasData) {
  //         return MainPage();
  //       } else {
  //         return LoginPage();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: Loader());
        }else if(snapshot.hasError){
          ToastMessage.showErrorToast("Something went Wrong Please Try again!.. ");
          return Authenticate();
        } else if(snapshot.hasData) {
          return HomeScreen();
        }else {
          return Authenticate();
        }
      },

    ),
  );
}
  // @override
  // Widget build(BuildContext context) {
  //   //return either home or authenticate widget
  //   print('user from wrapper build started');
  //   final user = FirebaseAuth.instance.currentUser;
  //   print( user);
  //   if(user == null){
  //     print('called wrapper inside');
  //     return Authenticate();
  //   }else{
  //     print('called wrapper inside');
  //     return HomeScreen();
  //   }
  // }


