import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/screen/addJob/AddJobDetails.dart';
import 'package:employment_app/screen/job_details/job_provider_view.dart';
import 'package:employment_app/screen/profile/posted_job_list_view/update_posted_job.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// List for fetching data from firebase
DatabaseService databaseService = DatabaseService();
var jobTitle = [];
var jobDescription = [];
var numberOfPeople = [];
var hours = [];
var address = [];
var city = [];
var state = [];
var country = [];
bool spinKit = false;

class JobPostDetails extends StatefulWidget {
  final int count;
  final seeJobsFromFirebase;
  final jobDetailsDisplay;
  JobPostDetails(
      {this.count, this.seeJobsFromFirebase, this.jobDetailsDisplay});

  @override
  _JobPostDetailsState createState() => _JobPostDetailsState();
}

class _JobPostDetailsState extends State<JobPostDetails> {
  @override
  Widget build(BuildContext context) {
    print("seeJobsFromFirebase.docs:");
    jobTitle.clear();
    for (var data in widget.seeJobsFromFirebase.docs) {
      jobTitle.add(data.data()['Job Type']);
      jobDescription.add(data.data()['Job Description']);
      numberOfPeople.add(data.data()['Number of People']);
      hours.add(data.data()['Time']);
      address.add(data.data()['Job Address']);
      city.add(data.data()['City']);
      state.add(data.data()['State']);
      country.add(data.data()['Country']);
    }
    print(jobTitle);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Job description'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinKit,
        child: SingleChildScrollView(
          child: Column(children: [
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
                                      text: jobTitle[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'No of pepole needed:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: numberOfPeople[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Hours:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: hours[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Description:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: jobDescription[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Address:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: address[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'City:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: city[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'State:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: state[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Country:',
                                style: largePrimaryColorsemiBold(),
                                children: [
                                  TextSpan(
                                      text: country[widget.count],
                                      style: regularBlackColorRegular())
                                ]),
                          ),
                          //        )
                          //)
                        ])),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              FlatButton.icon(
                  color: primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePostedJob(widget.count),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.update,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Update'.toUpperCase(),
                    style: largewhiteColorBold(),
                  )),
              FlatButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Delete'.toUpperCase(),
                    style: largewhiteColorBold(),
                  ),
                  color: primaryColor,
                  onPressed: () async {
                    // Delete that post
                    // ignore: unnecessary_statements
                    databaseService.jobId();
                    // databaseService.display();
                    print('Count:${widget.count}');

                    // setState(() {
                    //   spinKit = true;
                    // });

                    await databaseService.deleteJobDetails(widget.count);
                    setState(() {
                      spinKit = false;
                    });

                    Fluttertoast.showToast(
                      backgroundColor: primaryColor,
                      textColor: Colors.white,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      msg: 'Deleted suceessfully',
                    );
                    setState(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              flag: 0,
                            ),
                          ),
                          (route) => false);
                    });
                  }),
            ])
          ]),
        ),
      ),
    );
  }
}
