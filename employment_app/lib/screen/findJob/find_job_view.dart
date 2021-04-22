import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/globals/Globals.dart';
import 'package:employment_app/globals/validation.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/my_packages/custom_country_state_city.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int flag = 1;

class FindJobView extends StatefulWidget {
  @override
  _FindJobViewState createState() => _FindJobViewState();
}

class _FindJobViewState extends State<FindJobView> {
  final _formFindJob = GlobalKey<FormState>();

  //*******************type of job******************//
  String selectTypeOfJob;
  String selectTime;
  String countryValue;
  String stateValue;
  String cityValue;

  Future<bool> _willPopCallBack() async {
    print("will pop work");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          cityValue: cityValue,
          countryValue: countryValue,
          stateValue: stateValue,
          selectTime: selectTime,
          selectTypeOfJob: selectTypeOfJob,
          flag: 0,
        ),
      ),
          (route) => false,
    );
    return Future.value(true);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Find Job'),
          backgroundColor: primaryColor,
        ),
        body: WillPopScope(
          onWillPop:_willPopCallBack,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  screenWidth(context) * 0.05,
                  screenHeight(context) * 0.03,
                  screenWidth(context) * 0.05,
                  screenHeight(context) * 0.03),
              child: Form(
                key: _formFindJob,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      'Type of Job',
                      style: regularPrimaryColorSemiBold(),
                    )),
                    SizedBox(
                      height: screenHeight(context) * 0.005,
                    ),
                    DropdownButtonFormField(
                      isExpanded: true,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: primaryColor,
                      hint: Text('Select type of job'),
                      value: selectTypeOfJob,
                      items: typeOfJob.map((e) {
                        return DropdownMenuItem(value: e, child: new Text(e));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectTypeOfJob = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Please select" : null,
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.035,
                    ),
                    Container(
                      child: Text(
                        'Working hours',
                        style: regularPrimaryColorSemiBold(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.005,
                    ),
                    DropdownButtonFormField(
                      isExpanded: true,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: primaryColor,
                      hint: Text('Select time'),
                      value: selectTime,
                      items: time.map((e) {
                        return DropdownMenuItem(value: e, child: new Text(e));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectTime = newValue;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Please select" : null,
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.035,
                    ),
                    CustomSelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.035,
                    ),
                    Center(
                      child: FlatButton(
                        color: primaryColor,
                        onPressed: () {
                          if (_formFindJob.currentState.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    cityValue: cityValue,
                                    countryValue: countryValue,
                                    stateValue: stateValue,
                                    selectTime: selectTime,
                                    selectTypeOfJob: selectTypeOfJob,
                                    flag: 1,
                                  ),
                                ));
                          }
                        },
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: largewhiteColorBold(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
