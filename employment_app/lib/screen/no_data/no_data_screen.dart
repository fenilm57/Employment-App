import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(
              height: screenHeight(context) * 0.25,
          width: screenWidth(context) * 0.3,
          child: Image.asset(
            'lib/assets/images/No-data.png', fit: BoxFit.contain,),
        ),
        Container(child: RichText(text: TextSpan(text: 'Sorry!',style:largeBlackColorsemiBold(),children: [
          TextSpan(text: 'No job availbe right now',style: regularBlackColorRegular())
        ]),)
          //Text('No job availbe right Now',style: regularBlackColorRegular(),
        ),
    SizedBox(
    height: screenHeight(context)*0.01,
    ),
    Container(
    child: Text('Please try with another',style: regularBlackColorRegular(),),
    )
    ]
    )
    )
    );
  }
}
