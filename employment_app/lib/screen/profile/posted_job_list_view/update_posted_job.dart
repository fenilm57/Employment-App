import 'package:employment_app/services/database.dart';
import 'package:employment_app/widgets/home_list_view.dart';
import 'package:flutter/material.dart';
import 'package:employment_app/style/Style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:employment_app/globals/Globals.dart';

DatabaseService databaseService = DatabaseService();

class UpdatePostedJob extends StatefulWidget {
  final int count;
  UpdatePostedJob(this.count);
  @override
  _UpdatePostedJobState createState() => _UpdatePostedJobState();
}

bool showSpinner = false;

class _UpdatePostedJobState extends State<UpdatePostedJob> {
  final _formJobDetailsUpdate = GlobalKey<FormState>();

  FocusNode jobType = FocusNode();
  FocusNode jobDiscription = FocusNode();

  //***************************No of people needed */
  List<String> noOfPeople = ['1', '2', '3', '4', '5', '5 to 10', 'Above 10'];
  String selectPeople;

  //*************************Time ******************** */

  String selectTime;

  //*************************job type ******************** */

  String jobOfType;

  final _jobdiscriptionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Update Job'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            screenWidth(context) * 0.05,
            screenHeight(context) * 0.03,
            screenWidth(context) * 0.05,
            screenHeight(context) * 0.03),
        child: Form(
            key: _formJobDetailsUpdate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //**************************Type of job************************ */
                /*Container(
                      child: Text(
                        'Type of Job',
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
                        validator: (value) =>
                        value == null ? "Please select" : null,
                        hint: Text('Select Type of job'),
                        value: jobOfType,
                        items: typeOfJob.map((e) {
                          return DropdownMenuItem(value: e, child: new Text(e));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            jobOfType = newValue;
                          });
                        }),
                    SizedBox(
                      height: screenHeight(context) * 0.035,
                    ),*/
                //**************Select No of People*************** */
                Container(
                  child: Text('Select No of People',
                      style: regularPrimaryColorSemiBold()),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.005,
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: primaryColor,
                    validator: (value) =>
                        value == null ? "Please select" : null,
                    hint: Text('Select No of People'),
                    value: selectPeople,
                    items: noOfPeople.map((e) {
                      return DropdownMenuItem(value: e, child: new Text(e));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectPeople = newValue;
                      });
                    }),
                //******************Select Time************************* */
                SizedBox(
                  height: screenHeight(context) * 0.035,
                ),
                Container(
                  child: Text(
                    'Select Time',
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
                    hint: Text('Select Time'),
                    validator: (value) =>
                        value == null ? "Please select" : null,
                    value: selectTime,
                    items: time.map((e) {
                      return DropdownMenuItem(value: e, child: new Text(e));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectTime = newValue;
                      });
                    }),
                SizedBox(
                  height: screenHeight(context) * 0.035,
                ),

                //************************Job Discription********************** */
                TextFormField(
                  controller: _jobdiscriptionController,
                  focusNode: jobDiscription,
                  autofocus: false,
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: 'Job Description',
                      labelStyle: regularPrimaryColorSemiBold()),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.035,
                ),

                Center(
                  child: FlatButton(
                      color: primaryColor,
                      onPressed: () async {
                        if (_formJobDetailsUpdate.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          // Firestore add data

                          databaseService.jobId();
                          databaseService.display();
                          await databaseService.updateJobDetailsAndUpdate(
                            numberOfPeople: selectPeople,
                            jobDescription: _jobdiscriptionController.text,
                            time: selectTime,
                            count: widget.count,
                          );

                          Fluttertoast.showToast(
                              backgroundColor: primaryColor,
                              textColor: Colors.white,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                              msg: 'Job updated sucessfully!!!');

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: largewhiteColorBold(),
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
