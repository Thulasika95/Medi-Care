import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/services/auth.dart';
//import 'package:share/share.dart';
import 'package:image_share/image_share.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new UserOptions(),
    );
  }
}

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {

  @override
  void initstate() {
    super.initState();
  }

  Future<void> share_button() async {
    await ImageShare.shareImage(filePath: cameraFile.path);
  }

  Future<void> share_button1() async {
    await ImageShare.shareImage(filePath: galleryFile.path);
  }
  //save the result of gallery file
  File galleryFile;

  //save the result of camera file
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
         maxHeight: 2000.0,
         maxWidth: 2000.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {});
    }

    //display image selected from camera
    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1500.0,
        maxWidth: 1500.0,
      );
      print("You selected camera image : " + cameraFile.path);
      setState(() {});
    }

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Prescription'),
        centerTitle: true,

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

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage('images/presc.jpeg'),
                fit: BoxFit.cover,
              ),
              //Image(image: AssetImage('assets/ambulance.jpg'),),

              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    //height: 150,
                    //width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Upload Prescription',
                          style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                        Text(
                          'Upload Your Prescription and tell us what you need, We do the rest!',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image(
                    image: AssetImage('images/cameraa.png'),
                    height: 75,
                  ),
                  Image(
                    image: AssetImage('images/galleryy.png'),
                    height: 75,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      'Camera',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.blueAccent,
                    onPressed: imageSelectorCamera,
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.blueAccent,
                        onPressed: imageSelectorGallery,
                      )


                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  displaySelectedFile(galleryFile),

                  Center(
                    child: Container(
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text('Share Gallery Image', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),),
                          color: Colors.blueAccent,
                          onPressed: (){
                            share_button1();
                          }

                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  displaySelectedFile(cameraFile)
                ],
              ),

              SizedBox(
                height: 1.0,
              ),

                Center(
                  child: Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text('Share Camera Image', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),),
                      color: Colors.blueAccent,
                      onPressed: (){
                        share_button();
                      }

                    ),

                  ),
                ),



            ],
          ),
        ),
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      //height: 200.0,
      //width: 300.0,
      child: file == null
          ? new Text('')
          : new Image.file(file),
    );

  }
}
