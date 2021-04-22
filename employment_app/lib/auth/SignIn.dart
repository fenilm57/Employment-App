import 'package:employment_app/auth/authenticate.dart';
import 'package:employment_app/globals/Globals.dart';
import 'package:employment_app/globals/validation.dart';
import 'package:employment_app/style/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

Authenticate authenticate = Authenticate();

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNodeOne = FocusNode();

  bool passwordVisiable;
  bool showSpinner = false;

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  // Phone verification function

  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential result;

  @override
  void initState() {
    super.initState();
    passwordVisiable = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backprimaryColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.only(
                  top: screenHeight(context) * 0.05,
                  left: screenWidth(context) * 0.04),
              color: primaryColor,
              height: screenHeight(context) * 0.6,
              child: Column(
                children: [
                  Container(
                    child: Text('WELCOME', style: extralargeWhiteSemiBold()),
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(right: screenWidth(context) * 0.1),
                      child: Text(
                        'To Employement Seeking App',
                        style: largeWhiteSemiBold(),
                      )),
                ],
              ),
            ),
            Container(height: screenHeight(context) * 0.4),
          ]),
          Container(
            alignment: Alignment.center,
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                height: screenHeight(context) * 0.45,
                margin: EdgeInsets.only(
                    left: screenWidth(context) * 0.1,
                    right: screenWidth(context) * 0.1,
                    top: screenHeight(context) * 0.1,
                    bottom: screenHeight(context) * 0.1),
                padding: EdgeInsets.only(
                    left: screenWidth(context) * 0.01,
                    right: screenWidth(context) * 0.01,
                    top: screenHeight(context) * 0.01,
                    bottom: screenHeight(context) * 0.01),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///Mobile no ****************************************************************************
                        Container(
                          width: screenWidth(context) * 0.7,
                          margin: EdgeInsets.only(
                              left: screenWidth(context) * 0.02,
                              right: screenWidth(context) * 0.02),
                          child: TextFormField(
                            validator: validateMobile,
                            autofocus: false,
                            controller: _phoneController,
                            focusNode: _focusNodeOne,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefix: Text("$countryCode "),
                              labelText: 'Mobile No.',
                              labelStyle: _focusNodeOne.hasFocus
                                  ? regularBlueColor()
                                  : regulargreyColor(),
                              //  errorText: validateMobile.toString()
                            ),
                          ),
                        ),

                        /// Sign In button *************************************************************************
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          color: primaryColor,
                          textColor: whiteColor,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              final phoneNumber =
                                  countryCode + _phoneController.text.trim();

                              print(phoneNumber);
                              setState(() {
                                showSpinner = true;
                              });
                              authenticate.loginUser(phoneNumber, context);
                            }
                            // if (result == null) {
                            //   setState(() {
                            //     loading = false;
                            //   });
                            // }
                          },
                          child: Text(
                            'Sign In',
                            style: regularwhiteColorBold(),
                          ),
                        ),

                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              'OR',
                              style: regularprimaryColorBold(),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showSpinner = true;
                                });
                                authenticate.signInWithGoogle(context);
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                child: Image.asset(
                                    'lib/assets/images/google.png',
                                    fit: BoxFit.contain),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     // signInWithFacebook();
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => HomeScreen(),
                            //       ),
                            //     );
                            //   },
                            //   child: Container(
                            //     height: 45,
                            //     width: 80,
                            //     child: Image.asset(
                            //         'lib/assets/images/facebookLogo.png',
                            //         fit: BoxFit.contain),
                            //   ),
                            // ),
                          ],
                        ),
                        // GestureDetector(
                        //     onTap: () {
                        //       print(_auth.currentUser);

                        //       signOutUser();
                        //       print('Sign out');
                        //       print(_auth.currentUser);
                        //     },
                        //     child: Container(
                        //         alignment: Alignment.center,
                        //         child: RichText(
                        //           text: TextSpan(
                        //               text: 'Don\'t have an account?',
                        //               style: smallBlackColorRegular(),
                        //               children: [
                        //                 TextSpan(
                        //                     text: 'Sign Out',
                        //                     style:
                        //                         smallPrimaryColorSemiBold())
                        //               ]),
                        //         )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // )
        ],
      ),
    );
  }
}
