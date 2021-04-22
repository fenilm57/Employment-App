import 'package:employment_app/globals/Globals.dart';
import 'package:employment_app/globals/validation.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/screen/addJob/AddJobDetails.dart';
import 'package:employment_app/screen/profile/profile_view.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

DatabaseService databaseService = DatabaseService();
HomeScreen homeScreen = HomeScreen();
String uid = homeScreen.inputData();

// ignore: must_be_immutable
class AddPersonalDetails extends StatelessWidget {
  final _formKeyDetails = GlobalKey<FormState>();
  //**********Nodes ******************************** */
  FocusNode fristnameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode mobileNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();

  //***************Controllers**********************  */
  final _fristnameController = new TextEditingController();
  final _lastnameController = new TextEditingController();
  final _mobilenoController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Add Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(
              screenWidth(context) * 0.05,
              screenHeight(context) * 0.03,
              screenWidth(context) * 0.05,
              screenHeight(context) * 0.03),
          child: Form(
            key: _formKeyDetails,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //***************Frist Name**************************** */
                TextFormField(
                  controller: _fristnameController,
                  focusNode: fristnameNode,
                  validator: validateName,
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: screenHeight(context) * 0.03),

                //**************Last name****************************** */
                TextFormField(
                    controller: _lastnameController,
                    focusNode: lastNameNode,
                    validator: validateName,
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    )),
                SizedBox(height: screenHeight(context) * 0.03),
                //***************Mobile Number **************** */

                TextFormField(
                  controller: _mobilenoController,
                  focusNode: mobileNode,
                  validator: validateMobile,
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefix: Text('$countryCode'),
                    labelText: 'Mobile Number',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: screenHeight(context) * 0.03),

                //********************Email ***************** */
                TextFormField(
                  controller: _emailController,
                  focusNode: emailNode,
                  validator: validateEmail,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: screenHeight(context) * 0.03),

                //*****************Address ********************** */
                TextFormField(
                  controller: _addressController,
                  focusNode: addressNode,
                  validator: validateAddress,
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: screenHeight(context) * 0.03),

                //******************Next Button*************** */
                FlatButton(
                  color: primaryColor,
                  onPressed: () async {
                    if (_formKeyDetails.currentState.validate()) {
                      await databaseService.updateAddUserDetails(
                        firstName: _fristnameController.text,
                        lastName: _lastnameController.text,
                        phoneNumber: _mobilenoController.text,
                        email: _emailController.text,
                        address: _addressController.text,
                        uid: uid,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileView(),
                        ),
                      );
                      Fluttertoast.showToast(
                        backgroundColor: primaryColor,
                        textColor: Colors.white,
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                        msg: 'Profile Created',
                      );
                    }
                  },
                  child: Text(
                    'Submit'.toUpperCase(),
                    style: largewhiteColorBold(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
