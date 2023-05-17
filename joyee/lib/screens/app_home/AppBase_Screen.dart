import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joyee/screens/app_home/class_builder.dart';
import 'package:joyee/screens/app_home/home.dart';
import 'package:joyee/services/api_services/authenticate_service.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';
import 'package:joyee/utils/popups/dialogs.dart';
import 'package:kf_drawer/kf_drawer.dart';

class HomeScreen extends StatefulWidget {
  // int pageNumber = 0;
  //
  // HomeScreen(this.pageNumber);
  //
  static const routeName = '/home';
  // @override
  // _HomeScreenState createState() => _HomeScreenState(pageNumber);
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;
  final AuthenticateService _authenticateService = AuthenticateService();



  double drawerItemHeight = 60;
  double drawerItemWidth = 300;
  double drawerItemOpacity = 0.6;
  double drawerItemBorderRadius = 10;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(

      initialPage: ClassBuilder.fromString('Home'),

      items: [
        KFDrawerItem.initWithPage(
          text: Container(
            width: drawerItemWidth,
            height: drawerItemHeight,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(drawerItemBorderRadius)),
                color: Colors.black.withOpacity(drawerItemOpacity)
            ),
            child: Row(
              children: [
                Icon(Icons.home, color: Colors.white),
                SizedBox(width: 10,),
                Container(
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          // icon: Icon(Icons.home, color: Colors.white),
          page: Home(),
        ),
      ],

    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = _authenticateService.authUser;
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(drawerItemOpacity)
            ),
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              children: <Widget>[
                Container(

                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage(APP_AVATAR_PATH),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('DUMMY USER NAME', style: new TextStyle(fontSize: 17, color: Colors.white)),
                    new SizedBox(height: 2),
                    new Text(user!.email!.trim(), style: new TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Container(
            width: drawerItemWidth,
            height: drawerItemHeight,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(drawerItemOpacity),
              borderRadius: BorderRadius.all(Radius.circular(drawerItemBorderRadius)),
            ),
            child: Row(
              children: [
                Icon(Icons.settings, color: Colors.white),
                SizedBox(width: 10,),
                Container(
                  child: TextButton(
                    onPressed: () async {
                      Dialogs.confirm(context, "Confirm Your Action", "Do you want to log out from " + APP_NAME + "?", signOut );

                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),

                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   // colors: [Color.fromRGBO(31, 58, 47, 1.0), Color.fromRGBO(31, 58, 47, 1.0)],
          //   colors: [Colors.brown, Colors.black54],
          //   tileMode: TileMode.repeated,
          // ),
          image: DecorationImage(
            image: AssetImage(APP_BACKGROUND_PATH),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.dstATop),
          ),
        ),
      ),
    );

  }
 void signOut(){
   try{
     _authenticateService.signOut();
   }catch(exception){
     ToastMessage.showErrorToast("Error Occurred while sign out from the application..");
   }
  }

}
/*

 */
