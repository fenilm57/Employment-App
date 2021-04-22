import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/screen/job_details/job_details_view.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// List for fetching data from firebase
var jobTitle = [];
var jobDescription = [];
var city = [];
var state = [];
var country = [];
int count = 0;

class JobsListView extends StatefulWidget {
  final String selectTypeOfJob;
  final String selectTime;
  final String countryValue;
  final String stateValue;
  final String cityValue;
  final int flag;

  JobsListView({
    this.selectTime,
    this.cityValue,
    this.countryValue,
    this.selectTypeOfJob,
    this.stateValue,
    this.flag,
  });

  @override
  _JobsListViewState createState() => _JobsListViewState();
}

class _JobsListViewState extends State<JobsListView> {
  @override
  Widget build(BuildContext context) {
    final seeJobsFromFirebase = Provider.of<QuerySnapshot>(context);
    print("seeJobsFromFirebase.docs:");
    setState(() {
      jobTitle.clear();
      jobDescription.clear();
    });
    void displayAll() {
      for (var data in seeJobsFromFirebase.docs) {
        jobTitle.add(data.data()['Job Type']);
        jobDescription.add(data.data()['Job Description']);
        city.add(data.data()['City']);
        state.add(data.data()['State']);
        country.add(data.data()['Country']);
      }
    }

//***************************Filter below***********/
    void displayFilter() {
      for (var data in seeJobsFromFirebase.docs) {
        if (widget.selectTypeOfJob == data.data()['Job Type'] &&
            widget.selectTime == data.data()['Time'] &&
            widget.countryValue == data.data()['Country'] &&
            widget.stateValue == data.data()['State'] &&
            widget.cityValue == data.data()['City']) {
          // adding jobs in lists
          count++;
          jobTitle.add(data.data()['Job Type']);
          jobDescription.add(data.data()['Job Description']);
          city.add(data.data()['City']);
          state.add(data.data()['State']);
          country.add(data.data()['Country']);
          // numberOfPeople.add(data.data()['Number of People']);
          // hours.add(data.data()['Time']);
          // address.add(data.data()['Job Address']);
        }
      }
      if (jobTitle.isEmpty) {
        print('No data Found');
      }
    }

    print('jobTitle$jobTitle');
    if (widget.flag == null || widget.flag == 0) {
      displayAll();
    } else {
      displayFilter();
    }

    //****************************no Data Page******************************************
    // return NoData();

    //*****************************List view*********************************************
    return ListView.builder(
        itemCount: (widget.flag == null || widget.flag == 0)
            ? seeJobsFromFirebase.size
            : count,
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailsView(
                  count: i,
                  seeJobsFromFirebase: seeJobsFromFirebase,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(screenWidth(context) * 0.02,
                  screenHeight(context) * 0.01, screenWidth(context) * 0.02, 0),
              //height: 150,
              width: screenWidth(context),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.only(left: screenWidth(context) * 0.03),
                        child: Text(
                          jobTitle[i],
                          style: largePrimaryColorsemiBold(),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth(context) * 0.03,
                          screenHeight(context) * 0.01,
                          screenWidth(context) * 0.02,
                          screenHeight(context) * 0.01),
                      child: Text(
                        jobDescription[i],
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth(context) * 0.03,
                          screenHeight(context) * 0.005,
                          screenWidth(context) * 0.02,
                          screenHeight(context) * 0.001),
                      child: Text(
                        '${city[i]}, ${state[i]}',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth(context) * 0.03,
                          screenHeight(context) * 0.005,
                          screenWidth(context) * 0.02,
                          screenHeight(context) * 0.01),
                      child: Text(
                        country[i],
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    // SizedBox(height: 35,),
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.visibility, size: 20),
                          SizedBox(width: screenWidth(context) * 0.02),
                          Container(
                              // decoration: BoxDecoration(color: primaryColor),
                              padding: EdgeInsets.only(
                                  right: screenWidth(context) * 0.03,
                                  bottom: screenHeight(context) * 0.01),
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
        });
  }
}
