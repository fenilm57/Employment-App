import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/screen/profile/AddPersonalDetails.dart';
import 'package:employment_app/screen/profile/posted_job_list_view/posted_job_list_view.dart';
import 'package:employment_app/screen/profile/profile_view.dart';
import 'package:employment_app/style/Style.dart';
import 'package:employment_app/widgets/home_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home_screen.dart';
import 'image_picker/custom_image_picker.dart';

var firstname;
var lastname;
var address;
var phone;
int flag = 0;
var email;
var userId;

HomeScreen homeScreen = HomeScreen();
String uid = homeScreen.inputData();

class ProfileDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seeUserFromFirebase = Provider.of<QuerySnapshot>(context);
    print("seeUsersFromFirebase.docs:");
    print(seeUserFromFirebase.docs.length);

    for (var data in seeUserFromFirebase.docs) {
      if (uid == data.data()['UID']) {
        print('DataUid: ${data.data()['UID']}');
        firstname = (data.data()['First Name']);
        lastname = (data.data()['Last Name']);
        email = (data.data()['Email']);
        phone = (data.data()['Phone Number']);
        address = (data.data()['Address']);
        flag = 0;
        break;
      } else {
        flag = 1;
      }
    }

    if (flag == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPersonalDetails(),
        ),
      );
    }
    print(flag);
    print('User Id: $uid');

    print('Firstname=$firstname');
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        //Navigator.pushNamedAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(
              screenWidth(context) * 0.05,
              screenHeight(context) * 0.05,
              screenWidth(context) * 0.05,
              screenHeight(context) * 0.05),
          height: screenHeight(context) * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                //  margin: EdgeInsets.only(right: screenWidth(context)*0.1),
                child: Center(child: CustomImagePicker()),
              ),
              RichText(
                text: TextSpan(
                    text: 'First name: ',
                    style: largePrimaryColorsemiBold(),
                    children: [
                      TextSpan(
                          text: '$firstname', style: regularBlackColorRegular())
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Last name: ',
                    style: largePrimaryColorsemiBold(),
                    children: [
                      TextSpan(
                          text: '$lastname', style: regularBlackColorRegular())
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Mobile no: ',
                    style: largePrimaryColorsemiBold(),
                    children: [
                      TextSpan(
                          text: '$phone', style: regularBlackColorRegular())
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Email: ',
                    style: largePrimaryColorsemiBold(),
                    children: [
                      TextSpan(
                          text: '$email', style: regularBlackColorRegular())
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Address: ',
                    style: largePrimaryColorsemiBold(),
                    children: [
                      TextSpan(
                          text: '$address', style: regularBlackColorRegular())
                    ]),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostedJobListView())),
                  child: Container(
                    child: Text(
                      'Job Posted'.toUpperCase(),
                      style: largeDiffrentColorsemiBold(),
                    ),
                  ),
                )
              ])
//                RichText(
//                  text: TextSpan(
//                      text: 'Discription: ',
//                      style: largePrimaryColorsemiBold(),
//                      children: [
//                        TextSpan(
//                            text: '${widget.discription}',
//                            style: regularBlackColorRegular())
//                      ]),
//                ),
//                RichText(
//                  text: TextSpan(
//                      text: 'No of people : ',
//                      style: largePrimaryColorsemiBold(),
//                      children: [
//                        TextSpan(
//                            text: '${widget.noOfPeople}',
//                            style: regularBlackColorRegular())
//                      ]),
//                ),
//                RichText(
//                  text: TextSpan(
//                      text: 'Time: ',
//                      style: largePrimaryColorsemiBold(),
//                      children: [
//                        TextSpan(
//                            text: '${widget.time}',
//                            style: regularBlackColorRegular())
//                      ]),
//                ),
//                Center(child:
//                    FlatButton(
//                        color: primaryColor,
//                        onPressed: () => Navigator.pushAndRemoveUntil(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => HomeScreen()),
//                            (route) => false),
//                        child: Text(
//                          'Submit'.toUpperCase(),
//                          style: largewhiteColorBold(),
//                        ))
//                )
            ],
          ),
        ),
      ),
    );
  }
}
