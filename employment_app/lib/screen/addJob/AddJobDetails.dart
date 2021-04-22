import 'package:employment_app/globals/Globals.dart';
import 'package:employment_app/globals/validation.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/my_packages/custom_country_state_city.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// UID fetch
HomeScreen homeScreen = HomeScreen();
String uid = homeScreen.inputData();
// Spinner
bool showSpinner = false;

DatabaseService databaseService = DatabaseService();

class AddJobDetails extends StatefulWidget {
  final int flag;
  AddJobDetails({this.flag});
  @override
  _AddJobDetailsState createState() => _AddJobDetailsState();
}

class _AddJobDetailsState extends State<AddJobDetails> {
  final _formJobDetails = GlobalKey<FormState>();

  //**********************Nodes******************************************** */
  FocusNode jobType = FocusNode();
  FocusNode jobDiscription = FocusNode();
  FocusNode pinCodeNode = FocusNode();
  FocusNode jobAddress = FocusNode();

  //*********************Controller *******************************************
  //final _typeOFJobController = new TextEditingController();
  final _jobdiscriptionController = new TextEditingController();
  final _pinCodeController = new TextEditingController();
  final _jobAddressController = new TextEditingController();

  //***************************No of people needed */
  List<String> noOfPeople = ['1', '2', '3', '4', '5', '5 to 10', 'Above 10'];
  String selectPeople;

  //*************************Time ******************** */

  String selectTime;

  //*************************job type ******************** */

  String jobOfType;

  //*************************select_country_state_city*****************/

  String countryValue;
  String stateValue;
  String cityValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Create Job'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                screenWidth(context) * 0.05,
                screenHeight(context) * 0.03,
                screenWidth(context) * 0.05,
                screenHeight(context) * 0.03),
            child: Form(
                key: _formJobDetails,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //**************************Type of job************************ */
                    Container(
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
                    ),
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
                      child: Text('Select Time',
                          style: regularPrimaryColorSemiBold()),
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
//******************Select Country State city************************* */
                    /** see In Widget packege view */
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

                    //************************Job Address***************************/
                    TextFormField(
                      controller: _jobAddressController,
                      focusNode: jobAddress,
                      autofocus: false,
                      autocorrect: true,
                      validator: validateAddress,
                      decoration: InputDecoration(
                          labelText: 'Job Address',
                          labelStyle: regularPrimaryColorSemiBold()),
                      textInputAction: TextInputAction.next,
                    ),
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
                    //************************PinCode********************** */
                    TextFormField(
                      controller: _pinCodeController,
                      focusNode: pinCodeNode,
                      autofocus: false,
                      autocorrect: true,
                      keyboardType: TextInputType.phone,
                      validator: validatePinCode,
                      decoration: InputDecoration(
                          labelText: 'Pincode',
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
                            if (_formJobDetails.currentState.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              // Firestore add data
                              await databaseService.updateAddJobDetails(
                                jobType: jobOfType,
                                numberOfPeople: selectPeople,
                                city: cityValue,
                                country: countryValue,
                                state: stateValue,
                                jobAddress: _jobAddressController.text,
                                jobDescription: _jobdiscriptionController.text,
                                pincode: int.parse(_pinCodeController.text),
                                time: selectTime,
                                uid: uid,
                              );

                              Fluttertoast.showToast(
                                  backgroundColor: primaryColor,
                                  textColor: Colors.white,
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_LONG,
                                  msg: 'Post Added');

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            cityValue: cityValue,
                                            countryValue: countryValue,
                                            stateValue: stateValue,
                                            selectTime: selectTime,
                                            selectTypeOfJob: jobOfType,
                                            flag: 0,
                                          )),
                                  (route) => false);
                            }
                          },
                          child: Text(
                            'Submit'.toUpperCase(),
                            style: largewhiteColorBold(),
                          )),
                    ),
                    Center(
                        child: FlatButton(
                            color: primaryColor,
                            onPressed: () => clearTextFormField(),
                            child: Text(
                              'Clear'.toUpperCase(),
                              style: largewhiteColorBold(),
                            ))),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  clearTextFormField() {
    setState(() {
      _jobdiscriptionController.clear();
      _jobAddressController.clear();
      _pinCodeController.clear();
      selectPeople = null;
      selectTime = null;
      jobOfType = null;
      /*CustomSelectState().createState().selectedCity = null;
      CustomSelectState().createState().selectedState = null;
      CustomSelectState().createState().selectedCountry = null;*/
    });
  }
}
