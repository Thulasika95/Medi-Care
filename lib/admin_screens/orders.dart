import 'package:flutter/material.dart';
import 'package:loginapp/services/auth.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
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
        title: Text('Orders'),

        actions: [
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

      body: Container(
      decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/background.jpg"),
    fit: BoxFit.cover,
    ),
      ),

    ),
    );
  }
}
