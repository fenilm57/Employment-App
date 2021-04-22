import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/screen/profile/image_picker/custom_image_picker.dart';
import 'package:employment_app/screen/profile/profile_display.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userDetailsDisplay,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: Text('Profile'),
        ),
        body: ProfileDisplay(),
      ),
    );
  }
}
