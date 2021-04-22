import 'package:employment_app/auth/SignIn.dart';
import 'package:employment_app/screen/profile/AddPersonalDetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../home_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
UserCredential result;
final _codeController = TextEditingController();
User user;
String uid;

class Authenticate {
  Future<bool> loginUser(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        // Automatic verification of phone number
        result = await _auth.signInWithCredential(credential);
        User user = result.user;

        //Navigator PUSH to HomeScreen() in home_screen.dart
        uid = user.uid.toString();
        print("uid = $uid");

        Fluttertoast.showToast(
            msg: "Signed In",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);

        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          print('Error');
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verficationId, [int forceResendingToken]) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter OTP'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _codeController,
                  )
                ],
              ),
              actions: [
                FlatButton(
                  child: Text('Confirm'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    final String code = _codeController.text.trim();
                    AuthCredential credential = PhoneAuthProvider.credential(
                        smsCode: code, verificationId: verficationId);
                    result = await _auth.signInWithCredential(credential);
                    User user = result.user;
                    uid = user.uid.toString();
                    print("uid = $uid");

                    //Navigator PUSH to HomeScreen() in home_screen.dart
                    Fluttertoast.showToast(
                        msg: "Signed In",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      print('Error');
                    }
                  },
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  int loggedIn() {
    user = _auth.currentUser;
    if (user == null) {
      return 0;
    } else {
      return 1;
    }
  }

  //Google
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    result = await _auth.signInWithCredential(credential);
    User user = result.user;
    uid = user.uid.toString();
    print("uid = $uid");
    Fluttertoast.showToast(
        msg: "Signed In",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

    // Once signed in, return the UserCredential

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void signOutUser(BuildContext context) {
    print('Sign out');
    _auth.signOut();

    Fluttertoast.showToast(
        msg: "Sign Out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignIn(),
      ),
    );
  }

  String userID() {
    return uid;
  }
}
