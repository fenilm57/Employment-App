import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/screen/job_details/job_provider_view.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

DatabaseService databaseService = DatabaseService();
// List for fetching data from firebase
var jobTitle = [];
var jobDescription = [];
var numberOfPeople = [];
var hours = [];
var address = [];
var city = [];
var state = [];
var country = [];
var userids = [];

class JobDetailsView extends StatelessWidget {
  final int count;
  final seeJobsFromFirebase;
  JobDetailsView({this.count, this.seeJobsFromFirebase});

  @override
  Widget build(BuildContext context) {
    print("seeJobsFromFirebase.docs:");

    for (var data in seeJobsFromFirebase.docs) {
      jobTitle.add(data.data()['Job Type']);
      jobDescription.add(data.data()['Job Description']);
      numberOfPeople.add(data.data()['Number of People']);
      hours.add(data.data()['Time']);
      address.add(data.data()['Job Address']);
      city.add(data.data()['City']);
      state.add(data.data()['State']);
      country.add(data.data()['Country']);
      userids.add(data.data()['UID']);
    }
    print(jobTitle);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Job description'),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    screenWidth(context) * 0.05,
                    screenHeight(context) * 0.05,
                    screenWidth(context) * 0.05,
                    screenHeight(context) * 0.05),
                height: screenHeight(context) * 0.6,
                width: screenWidth(context),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth(context) * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Title: ',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: jobTitle[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'No of pepole needed:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: numberOfPeople[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Hours:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: hours[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Description:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: jobDescription[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Address:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: address[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'City:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: city[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'State:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: state[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Country:',
                              style: largePrimaryColorsemiBold(),
                              children: [
                                TextSpan(
                                    text: country[count],
                                    style: regularBlackColorRegular())
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FlatButton(
                color: primaryColor,
                onPressed: () {
                  //print('UserId: ${userids[count]}');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => JobProviderView(userids[count]),
                  //   ),
                  // );

                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                        height: screenHeight(context) * 0.25,
                        child: JobProviderView(userids[count])),
                  );
                },
                child: Text(
                  'Click to see Provider Details'.toUpperCase(),
                  style: largewhiteColorBold(),
                ),
              )
            ]),
      ),
    );
  }
}
