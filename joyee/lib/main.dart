import 'dart:ui';

// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:joyee/screens/app_home/class_builder.dart';
import 'screens/authenticate/wrapper.dart';
import 'package:joyee/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main () async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(HappyPetApp());
}


class HappyPetApp extends StatefulWidget {
  @override
  _HappyPetAppState createState() => _HappyPetAppState();
}

class _HappyPetAppState extends State<HappyPetApp> {
  double screenWidth = window.physicalSize.width;


  @override
  Widget build(BuildContext context) {

    return StreamProvider<User?>.value(
        value: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,

          title: APP_NAME,
          theme: ThemeData(primaryColor : THEME_COLOR, hintColor: COLOR_GREY, textTheme: screenWidth <500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT ),

          home: Wrapper(),
          navigatorObservers: [FlutterSmartDialog.observer],
          // here
          builder: FlutterSmartDialog.init(),
      ),
    );

  }
}
