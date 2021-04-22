import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/screen/job_details/job_details_view.dart';
import 'package:employment_app/screen/profile/posted_job_list_view/post_job_details.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

HomeScreen homeScreen = HomeScreen();

String uid = homeScreen.inputData();
var jobTitle = [];
var jobDescription = [];

class PostDisplay extends StatelessWidget {
  int count = 0;
  final jobDetailsDisplay;
  PostDisplay({this.jobDetailsDisplay});
  @override
  Widget build(BuildContext context) {
    final seeJobsFromFirebase = Provider.of<QuerySnapshot>(context);
    print("seeJobsFromFirebase.docs:");
    for (var data in seeJobsFromFirebase.docs) {
      if (uid == data.data()['UID']) {
        count++;
        jobTitle.add(data.data()['Job Type']);
        jobDescription.add(data.data()['Job Description']);
      }
    }
    print(jobTitle);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Center(child: Text('Job Posted : $count')),
      ),
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                jobTitle.clear();
                jobDescription.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobPostDetails(
                        count: i,
                        seeJobsFromFirebase: seeJobsFromFirebase,
                        jobDetailsDisplay: jobDetailsDisplay),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(screenWidth(context) * 0.02, screenWidth(context)*0.02,
                    screenWidth(context) * 0.02, 0),
                height: 150,
                width: screenWidth(context),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              left: screenWidth(context) * 0.03),
                          child: Text(
                            jobTitle[i],
                            style: largePrimaryColorsemiBold(),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth(context) * 0.02,
                            screenHeight(context) * 0.01,
                            screenWidth(context) * 0.02,
                            screenHeight(context) * 0.01),
                        child: Text(
                          jobDescription[i],
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.visibility, size: 20),
                            SizedBox(width: screenWidth(context) * 0.02),
                            Container(
                                // decoration: BoxDecoration(color: primaryColor),
                                padding: EdgeInsets.only(
                                    right: screenWidth(context) * 0.03),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'View',
                                  style: regularprimaryColorBold(),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
