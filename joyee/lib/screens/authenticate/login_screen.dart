import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:joyee/screens/app_home/AppBase_Screen.dart';
import 'package:joyee/services/api_services/authenticate_service.dart';
import 'package:joyee/utils/constants.dart';
import 'package:joyee/utils/custom_widgets/FormField.dart';
import 'package:joyee/utils/custom_widgets/addSpace_widget.dart';
import 'package:joyee/utils/custom_widgets/toastMessage.dart';

import '../../utils/custom_widgets/loader_widget.dart';
import 'authenticate.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  final VoidCallback onClickedSignUp;

  const LoginScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthenticateService _authenticateService = AuthenticateService();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  bool isLoading = false;

  //form field states
  String email = '';
  String password = '';
  String loginError = '';

  void _submit() async{
    print("Email :" + email);
    print("Password :" + password);
    setState(() => isLoading = true);

    await Future.delayed(Duration(seconds: 10));
    setState(() => isLoading = false);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HomeScreen();
    }));

    // dynamic result = await _authService.signInWithEmailAndPassword(email, password);
    // if(result == null){
    //   setState(() => loading = false);
    //   setState(() => loginError = 'Please check your Internet Connection');
    // }
    // if(result.toString().contains('no user record corresponding')){
    //   setState(() => loading = false);
    //   setState(() => loginError = 'Invalid Email, Please Sign Up!');
    // }
    // if(result.toString().contains('password is invalid')){
    //   setState(() => loading = false);
    //   setState(() => loginError = 'Invalid Password!');
    // }

  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return isLoading ? Loader() : Scaffold(

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomeScreen();
          }else{
            Authenticate();
          }
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  // gradient:LinearGradient(
                  //     colors: [
                  //       COLOR_BROWN,
                  //       COLOR_BROWN_LIGHT1
                  //     ],
                  //     begin: const FractionalOffset(0.4, 0.0),
                  //     end: const FractionalOffset(1.0, 0.0),
                  //     stops: [0.0, 1.0],
                  //     tileMode: TileMode.clamp),
                  image: DecorationImage(
                    image: AssetImage(APP_BACKGROUND_PATH),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(APP_BACKGROUND_2_PATH), // Replace with your background image path
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: 400,
                    width: 300,
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child:
                        Column(
                          children: <Widget>[
                            Image.asset(APP_LOGO_COVER_PATH),
                            //Email Field
                            TextFormField(
                              controller: emailFieldController,
                              decoration: customInputDecoration('ENTER YOUR EMAIL', size, Icons.email),

                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                if(value!.isEmpty || !value.contains('@')){
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              onChanged: (value){
                                setState(() => email = value);
                              },
                            ),
                            SizedBox(height: 12.0,),
                            // password Field
                            TextFormField(
                              controller: passwordFieldController,
                              decoration: customInputDecoration('ENTER YOUR PASSWORD', size, Icons.lock),
                              obscureText: true,
                              validator: (value){
                                if(value!.isEmpty || value.length <= 5){
                                  return 'Invalid Password';
                                }
                                return null;
                              },
                              onChanged: (value){
                                setState(() => password = value);
                              },
                            ),

                            Text(
                              loginError,
                              style: TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                           SizedBox(
                             height: 20,
                           ),
                           ElevatedButton(

                             child: Text(
                               'LOGIN',
                             ),
                             style: ElevatedButton.styleFrom(
                              primary: THEME_COLOR,
                               minimumSize: Size(size.width, size.height*0.05),
                               textStyle: TextStyle(
                                 color: COLOR_BLACK
                               )
                             ),
                             onPressed: () async{
                               if(_formKey.currentState!.validate()){
                                 signIn();
                               }

                             },

                           ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                    text: 'No Account? ',
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = widget.onClickedSignUp,
                                          text: "Sign Up Now",
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              color: Colors.blue,
                                              fontSize: 16
                                          )
                                      ),
                                    ]
                                )),


                          ],
                        ),
                      ),
                    ),

                  ),
                ),
              )
            ],
          );
        }
      ),
    );

  }
  Future signIn() async {
    setState(() => isLoading = true);
    try{
      dynamic result = await _authenticateService.signInWithEmailAndPassword(email, password);
      if(result == null){
        setState(() => isLoading = false);
        setState(() => loginError = 'Please check your Internet Connection');
      }
      if(result.toString().contains('no user record corresponding')){
        setState(() => isLoading = false);
        setState(() => loginError = 'Invalid Email, Please Sign Up!');
      }
      if(result.toString().contains('password is invalid')){
        setState(() => isLoading = false);
        setState(() => loginError = 'Invalid Password!');
      }
    } catch(exception){
      ToastMessage.showErrorToast("Error Occurred while sign in, Please try again !..");
      print(exception);
    }
    setState(() => isLoading = false);
  }
}

