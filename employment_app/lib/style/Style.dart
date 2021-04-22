import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Colors */
final whiteColor = const Color(0xFFFFFFFF);
final backprimaryColor = const Color(0xFFe7f2ec);
final secondryBackColor = const Color(0xFFe5e7e9);
final primaryColor = const Color(0xFF001652);
final secondryColor = const Color(0xFF006080);

///status Height */
double statusHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

///Screen height  */
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

///Screen Width */
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// Text Style  */

TextStyle regularBlueColor() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.blueAccent);
}

TextStyle regulargreyColor() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black45);
}

TextStyle regularwhiteColorBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: whiteColor);
}

TextStyle regularprimaryColorBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: primaryColor);
}

TextStyle largewhiteColorBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: whiteColor);
}

TextStyle largePrimaryColorBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Bold',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryColor);
}

TextStyle smallPrimaryColorSemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-SemiBold',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryColor);
}

TextStyle regularPrimaryColorSemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-SemiBold',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryColor);
}

TextStyle smallPrimaryColorRegular() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryColor);
}

TextStyle smallBlackColorRegular() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black);
}

TextStyle regularBlackColorRegular() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Regular',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black);
}

TextStyle largePrimaryColorsemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-SemiBold',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: primaryColor);
}

TextStyle largeBlackColorsemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-SemiBold',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black);
}


TextStyle largeDiffrentColorsemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-SemiBold',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.teal);
}


TextStyle extralargeWhiteSemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-Bold',
      fontStyle: FontStyle.italic,
      fontSize: 42,
      fontWeight: FontWeight.w500,
      color: Colors.white);
}

TextStyle largeWhiteSemiBold() {
  return TextStyle(
      fontFamily: 'SourceSansPro-SemiBold',
      fontStyle: FontStyle.italic,
      fontSize: 26,
      fontWeight: FontWeight.w100,
      color: Colors.white);
}
