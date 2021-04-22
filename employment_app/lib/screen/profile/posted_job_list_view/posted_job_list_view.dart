import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/screen/profile/posted_job_list_view/post_display.dart';
import 'package:employment_app/services/database.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostedJobListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().jobDetailsDisplay,
      child:
          PostDisplay(jobDetailsDisplay: DatabaseService().jobDetailsDisplay),
    );
  }
}
