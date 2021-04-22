import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/screen/findJob/find_job_view.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:employment_app/widgets/NavigationDrawer.dart';
import 'package:employment_app/widgets/home_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String userId;

class HomeScreen extends StatelessWidget {
  final String selectTypeOfJob;
  final String selectTime;
  final String countryValue;
  final String stateValue;
  final String cityValue;
  final int flag;

  HomeScreen({
    this.selectTime,
    this.flag,
    this.cityValue,
    this.countryValue,
    this.selectTypeOfJob,
    this.stateValue,
  });

  final FirebaseAuth auth = FirebaseAuth.instance;
  String inputData() {
    final User user = auth.currentUser;
    userId = user.uid.toString();

    return userId;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    print('flag=$flag');
    print('Home uid:${inputData()}');
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().jobDetailsDisplay,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          //  automaticallyImplyLeading: false,
          title: Text('Job'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FindJobView()))),
            /*IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              onPressed: () {
                print('Null is pressed');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobsListView(
                      flag: 0,
                    ),
                  ),
                );
              },
            ),*/
          ],
        ),
        drawer: NavigationDrawer(),
        body: JobsListView(
          cityValue: cityValue,
          countryValue: countryValue,
          stateValue: stateValue,
          selectTime: selectTime,
          selectTypeOfJob: selectTypeOfJob,
          flag: flag,
        ),
      ),
    );
  }
}
