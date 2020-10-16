import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/shared/loading.dart';
import 'package:loginapp/services/auth.dart';

class LoginPage extends StatefulWidget {
  //LoginPage({this.auth, this.onSignedIn});
  //final BaseAuth auth;
  //final VoidCallback onSignedIn;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
//here it returns the _LoginPageState
}

class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('images/login1.png');
    Image image = Image(
      image: assetImage,
      width: 100.0,
      height: 202.0,
    );
    return Container(
      child: image,
    );
  }
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  //the underscore _ is used to make a class private
//final List<String> userType =['Admin','Customer'];
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";
  String name = "";
  var userTypes = ['Admin', 'Customer'];
  var userType = 'Admin';
  FormType _formType = FormType.login;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          setState(() => loading = true);
          dynamic result =
              await _auth.signinWithEmailAndPassword(email, password);
          if (result == null) {
            setState(() => error = "plz enter a valid email or password");
            loading = false;
          }
//          FirebaseUser user = (await FirebaseAuth.instance
//              .signInWithEmailAndPassword(email: _email, password: _password))
//              .user;
          // print('sign in user:$userId');
        } else {
          setState(() => loading = true);
          String userId = await widget._auth
              .registerWithEmailAndPassword(email, name, password, userType);

          //   FirebaseUser user=(await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print('Register: $userId');
        }
        //widget.onSignedIn();
      } catch (e) {
        print('Error:$e');
        loading = false;
      }
    }
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading
        ? Loading()
        : Scaffold(
            appBar: new AppBar(
              title: Center(child: new Text('Login Page')),
            ),

            body:
            SingleChildScrollView(

              child: new Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),



                  padding: EdgeInsets.all(15.0),
                  child: new Form(
                    key: _formKey,
                    child: new Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch, //stretch login button
                      children: inputlogo() +
                          buildInputsMore() +
                          buildSubmitButtons(),
                    ),
                  )),
            ));

  }

  List<Widget> inputlogo() {
    SizedBox(height: 10.0);
    return [logo()];
  }

//  List<Widget> buildInputs() {
//    return [
//
//    ];
//  }

  List<Widget> buildInputsMore() {
    if (_formType == FormType.register) {
      return [
        new TextFormField(
          decoration:
              new InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), focusColor: Colors.black, ),
          validator: (value) =>
              value.isEmpty ? 'email can not be empty ' : null,
          onSaved: (value) => email = value,
        ),
        new TextFormField(
          decoration:
              new InputDecoration(labelText: 'Name', labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),focusColor: Colors.black),
          validator: (value) => value.isEmpty ? 'Enter name value ' : null,
          onSaved: (value) => name = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
          validator: (value) =>
              value.isEmpty ? 'password can not be empty ' : null,
          onSaved: (value) => password = value,
          obscureText: true, //hide password
        ),
        //drop down list
        new DropdownButton<String>(
          value: userType,
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
          ),
          onChanged: (String newValue) {
            setState(() {
              this.userType = newValue;
            });
          },
          items: userTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            );
          }).toList(),
        )
      ];
    } else {
      return [
        SizedBox(height: 3.0,),
        new TextFormField(
          decoration:
              new InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),focusColor: Colors.black),
          validator: (value) =>
              value.isEmpty ? 'email can not be empty ' : null,
          onSaved: (value) => email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          validator: (value) =>
              value.isEmpty ? 'password can not be empty ' : null,
          onSaved: (value) => password = value,
          obscureText: true, //hide password
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    SizedBox(height: 50.0);
    if (_formType == FormType.login) {
      return [
        SizedBox(height: 30.0),
        new RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)),
          child: new Text('Login', style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          onPressed: validateAndSubmit,
          color: Colors.blue,
        ),
        new FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            onPressed: moveToRegister,
            child: new Text('Create an account',
                style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue))),
        CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(Color(0xff19c71)),
        ),
      ];
    } else {
      return [
        SizedBox(height: 3.0,),
        new RaisedButton(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)),
          child: new Text('SignUp',
              style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black)),
          onPressed: validateAndSubmit,
          color: Colors.blue,

        ),
        new FlatButton(
            onPressed: moveToLogin,
            child: new Text('Have an account? Login',
                style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue, fontStyle: FontStyle.italic))),
      ];
    }
  }
}
