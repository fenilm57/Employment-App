import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';

class CreateDrawerHeader extends StatelessWidget {
  const CreateDrawerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.25,
      width: screenWidth(context),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('lib/assets/images/appLogo.jpg'))),
      child: Stack(
        children: [
          Positioned(
              bottom: 12.0,
              left: 12.0,
              right: 12.0,
              child: Container(
                  //margin: EdgeInsets.only(right: 12.0),
                  child: Text(
                'Welcome to Employment Seeking Application',
                style: largePrimaryColorBold(),
              )))
        ],
      ),
    );
  }
}
