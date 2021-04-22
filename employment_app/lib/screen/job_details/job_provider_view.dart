import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employment_app/home_screen.dart';
import 'package:employment_app/screen/profile/profile_display.dart';
import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:employment_app/demo.dart';
import 'job_details_view.dart';

//******************Variable for first name and mobile number */

String firstname = '';
String mobile = '';
int count = 0;

//*************************Above variable */

class JobProviderView extends StatelessWidget {
  final String userId;
  JobProviderView(this.userId);
  int i = 0;

  @override
  Widget build(BuildContext context) {
    print('USerID: $userId');
    // void displayAll() {
    //   for (var data in seeUsersFromFirebase.docs) {
    //     if (data.data()['UID'] == widget.userId) {
    //       firstname = (data.data()['First Name']);
    //       firstname = (data.data()['Phone Number']);
    //       break;
    //     }
    //   }
    // }

    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('UserDetails').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              if (document['UID'] == userId) {
                firstname = document['First Name'];
                mobile = document['Phone Number'];

                print('firstname: $firstname');
                print('mobile: $mobile');
              }
              return document['UID'] == userId
                  ? Container(
                margin: EdgeInsets.only(left:10,right: 10),
                  child:

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Provider Details',style: largePrimaryColorsemiBold(),),),
                          Container(
                            height: 110,
                            child:
                          Card(child:
                              Container(
                                padding: EdgeInsets.only(left:20),
                                  child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Name:',
                                  style: largePrimaryColorsemiBold(),
                                  children: [
                                    TextSpan(
                                        text: firstname,
                                        style: regularBlackColorRegular())
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Contact no:',
                                  style: largePrimaryColorsemiBold(),
                                  children: [
                                    TextSpan(
                                        text: mobile,
                                        style: regularBlackColorRegular())
                                  ]),
                            ),
                          ],
                    )
              ),))
                        ],
                      ))
                  : Container();
            }).toList(),
          );
        },
      ),
    );
  }
}
//         Container(
//           margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 85,
//                     backgroundColor: Colors.white,
//                     backgroundImage:
//                         AssetImage('lib/assets/images/user_avatar.png'),
//                   ),
//                 ],
//               ),
//               Container(
//                   margin: EdgeInsets.only(left: 20, top: 20),
//                   height: screenHeight(context) * 0.1,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       RichText(
//                         text: TextSpan(
//                             text: 'First name: $firstname',
//                             style: largePrimaryColorsemiBold(),
//                             children: [
//                               TextSpan(
//                                   text: '', style: regularBlackColorRegular())
//                             ]),
//                       ),
//                       RichText(
//                         text: TextSpan(
//                             text: 'Mobile no: $mobile',
//                             style: largePrimaryColorsemiBold(),
//                             children: [
//                               TextSpan(
//                                   text: '', style: regularBlackColorRegular())
//                             ]),
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
