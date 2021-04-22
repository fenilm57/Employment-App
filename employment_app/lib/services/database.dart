import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  var ids = [];
  String idforUpdate;
  final CollectionReference addJobDetails =
      FirebaseFirestore.instance.collection('JobDetails');

  final CollectionReference addUserDetails =
      FirebaseFirestore.instance.collection('UserDetails');

  Future<String> jobId() async {
    final add =
        await FirebaseFirestore.instance.collection('JobDetails').get().then(
              (QuerySnapshot snapshot) => {
                snapshot.docs.forEach((f) {
                  if (!ids.contains(f.reference.id)) {
                    ids.add(f.reference.id);
                    // print(ids);

                  }
                }),
              },
            );
  }

  void jobIdforUpdate() async {
    final add =
        await FirebaseFirestore.instance.collection('JobDetails').get().then(
              (QuerySnapshot snapshot) => {
                snapshot.docs.forEach((f) {
                  if (!ids.contains(f.reference.id)) {
                    idforUpdate = f.reference.id;
                  }
                }),
              },
            );
  }

//************************Updating data of post */
  Future updateJobDetailsAndUpdate(
      {String numberOfPeople,
      String time,
      String jobDescription,
      int count}) async {
    return await addJobDetails.doc(ids[count]).update({
      // 'Job Type': jobType,
      'Number of People': numberOfPeople,
      'Time': time,
      // 'Country': country,
      // 'State': state,
      // 'City': city,
      // 'Job Address': jobAddress,
      'Job Description': jobDescription,
      // 'Pincode': pincode
    });
  }

//********************Update and create Database for Job details****************/
  Future updateAddJobDetails({
    String uid,
    String jobType,
    String numberOfPeople,
    String time,
    String state,
    String country,
    String city,
    String jobAddress,
    String jobDescription,
    int pincode,
  }) async {
    return await addJobDetails.doc().set({
      'UID': uid,
      'Job Type': jobType,
      'Number of People': numberOfPeople,
      'Time': time,
      'Country': country,
      'State': state,
      'City': city,
      'Job Address': jobAddress,
      'Job Description': jobDescription,
      'Pincode': pincode
    });
  }

//********************Get add job detail from database****************/

  Stream<QuerySnapshot> get jobDetailsDisplay {
    return addJobDetails.snapshots();
  }

//********************Get add user profile from database****************/
  Stream<QuerySnapshot> get userDetailsDisplay {
    return addUserDetails.snapshots();
  }

//************************ Storing user profile in Database***********/
  Future updateAddUserDetails({
    String uid,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String address,
  }) async {
    return await addUserDetails.doc().set({
      'UID': uid,
      'First Name': firstName,
      'Last Name': lastName,
      'Email': email,
      'Address': address,
      'Phone Number': phoneNumber
    });
  }

  //***********************delete */
  Future deleteJobDetails(int count) async {
    print('count : $count');
    print('ids[count] : ${ids[count]}');
    await addJobDetails.doc(ids[count]).delete();
    ids.removeAt(count);
  }

  void display() {
    print('ids:$ids');
  }

  String displayUpdteId() {
    print('idforUpdate:$idforUpdate');
    return idforUpdate;
  }
  //*************************************//

}
