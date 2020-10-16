import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/cus_screens/edit_medicine.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/cus_screens/edit_profile.dart';
import 'package:loginapp/models/profile.dart';
import 'package:loginapp/providers/user_provider.dart';
import 'package:loginapp/services/auth.dart';
import 'package:provider/provider.dart';

class CusProfile extends StatefulWidget {
  @override
  _CusProfileState createState() => _CusProfileState();
}

class _CusProfileState extends State<CusProfile> {
  final databaseReference = Firestore.instance;
  final Firestore database = Firestore.instance;

  String userTypes = "";
  bool isLoading = false;

  readData() async {
    try {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      DocumentSnapshot snapshot = await databaseReference
          .collection('profile')
          .document(firebaseUser.uid)
          .get();
      // print(snapshot.data['userType']);
      String result = snapshot.data['name'];
      return snapshot;
      //print(result);
      setState(() {
        this.userTypes = result;
      });
    } catch (e) {
      print(e.toString());
    }
  }
//
//  Card buildItem(DocumentSnapshot doc) {
//    return Card(
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              'name: ${doc.data['name']}',
//              style: TextStyle(fontSize: 24),
//            ),
//            Text(
//              'todo: ${doc.data['email']}',
//              style: TextStyle(fontSize: 20),
//            ),
//            SizedBox(height: 12),
//          ],
//        ),
//      ),
//    );
//  }

  // readData _readData;
  @override
  void initState() {
    super.initState();
  }

  final AuthService _auth = AuthService();

  void _signedOut() async {
    try {
      await _auth.signOut();
      //onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile")),
        elevation: 1,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.supervised_user_circle,
            size: 30.0,
          ),
          onPressed: () {
            _signedOut();
          },
        ),
      ],
      ),


      body: FutureBuilder<dynamic>(
          future: readData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80.0,),
                    Center(
                      child: Image.asset(
                        'images/prof.png',
                          scale: 0.6
                      )
                    ),
                    SizedBox(height: 40.0),
                    Center(

                      child: Text(
                        snapshot.data['name'],
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                      ),

                    ),
                    Center(
                      child: Text(
                        snapshot.data['email'],
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                      ),
                    ),

                    SizedBox(height: 30.0,),

                      Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),),
                         color: Colors.blueAccent,
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SettingsUI()),
                            );
                          },
                        ),
                      ),


                  ],
                ),
              );
              // Text(snapshot.data['name']);
              // final List profile = snapshot.data;
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Firestore CRUD'),
//      ),
//      body: ListView(
//        padding: EdgeInsets.all(8),
//        children: <Widget>[
//          StreamBuilder<QuerySnapshot>(
//            stream: databaseReference.collection('profile').snapshots(),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return Column(
//                    children: snapshot.data.documents
//                        .map((doc) => buildItem(doc))
//                        .toList());
//              } else {
//                return SizedBox();
//              }
//            },
//          )
//        ],
//      ),
//    );
//  }
}

