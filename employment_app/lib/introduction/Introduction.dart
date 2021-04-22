// import 'package:employment_app/auth/SignIn.dart';
// import 'package:employment_app/style/Style.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class Introduction extends StatefulWidget {
//   @override
//   _IntroductionState createState() => _IntroductionState();
// }

// class _IntroductionState extends State<Introduction> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: backprimaryColor,
//         body: Container(
//           margin: EdgeInsets.only(
//               left: screenWidth(context) * 0.1,
//               right: screenWidth(context) * 0.1),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Text(
//                         'WELCOME',
//                         style: extralargePrimaryColorSemiBold(),
//                       ),
//                     ),
//                     Container(
//                         margin:
//                             EdgeInsets.only(right: screenWidth(context) * 0.1),
//                         child: Text(
//                           'To Employement Seeking App',
//                           style: largeSecondryColorSemiBold(),
//                         )),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: screenWidth(context),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     FlatButton(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18.0)),
//                         color: primaryColor,
//                         textColor: whiteColor,
//                         onPressed: () => Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => SignIn())),
//                         child: Text('Sign in')),
//                     // SizedBox(
//                     //   height: 30,
//                     // ),
//                     // FlatButton(
//                     //     shape: RoundedRectangleBorder(
//                     //         borderRadius: BorderRadius.circular(18.0)),
//                     //     color: primaryColor,
//                     //     textColor: whiteColor,
//                     //     onPressed: () => Navigator.push(context,
//                     //         MaterialPageRoute(builder: (context) => SignUp())),
//                     //     child: Text('Sign up'))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
