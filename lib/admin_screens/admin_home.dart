import 'package:flutter/material.dart';
import 'package:loginapp/Third.dart';
import 'package:loginapp/admin_screens/ManageProfile.dart';
import 'package:loginapp/admin_screens/addpage.dart';
import 'package:loginapp/admin_screens/admin_view.dart';
import 'package:loginapp/admin_screens/orders.dart';
import 'package:loginapp/cus_screens/manage_profile.dart';
import 'package:loginapp/admin_screens/view.dart';
import 'package:loginapp/models/medicine.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int currentPage = 0;
  final List<Widget> screens = [
    AdminView(),
    ManageProfile(),
    AdminHome(),
    MyAddPage(),
    View(),
    Orders()

  ];

  Widget currentScreen = AdminView();
  //backet allows to switch between pages
  final PageStorageBucket backet = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: backet, child: currentScreen),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = ManageProfile();
                    currentPage = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person,
                        color: currentPage == 0 ? Colors.blue : Colors.grey),
                    Text(
                      'Customer Details',
                      style: TextStyle(
                          color: currentPage == 0
                              ? Colors.blueAccent
                              : Colors.grey),
                    )
                  ],
                ),
                minWidth: 30,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = View();
                    currentPage = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.table_chart,
                        color: currentPage == 1 ? Colors.blue : Colors.grey),
                    Text(
                      'Medicines',
                      style: TextStyle(
                          color: currentPage == 1 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
                minWidth: 30,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = Orders();
                    currentPage = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.shopping_cart,
                        color: currentPage == 2 ? Colors.blue : Colors.grey),
                    Text(
                      'View Orders',
                      style: TextStyle(
                          color: currentPage == 2 ? Colors.blue : Colors.grey),
                    )
                  ],
                ),
                minWidth: 30,
              ),
//              MaterialButton(
//                onPressed: () {
//                  setState(() {
//                    currentScreen = MyAddPage();
//                    currentPage = 3;
//                  });
//                },
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(Icons.person,
//                        color: currentPage == 3 ? Colors.blue : Colors.grey),
//                    Text(
//                      'Add Image',
//                      style: TextStyle(
//                          color: currentPage == 3 ? Colors.blue : Colors.grey),
//                    )
//                  ],
//                ),
//                minWidth: 30,
//              )
            ],
          ),
        ),
      ),
    );
  }
}
