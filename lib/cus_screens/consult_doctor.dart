import 'package:flutter/material.dart';
import 'package:loginapp/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(ConsultDoctor());

class ConsultDoctor extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Consult Us'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/call.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                    SizedBox(height: 150.0,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(1000.0),
                        ),
                        onPressed: () {
                          customLaunch('tel:+94 0778679549');
                        },
                        color: Theme.of(context).backgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.phone_in_talk,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10.0,),
                            Text(
                              'Pharmacist',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),




                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(1000.0),
                        ),
                        onPressed: () {
                          customLaunch('tel:+94 0778679549');
                        },
                        color: Theme.of(context).backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.phone_in_talk,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10.0,),
                              Text(
                                'Doctor',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                            ],
                          ),

                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(1000.0),
                      ),
                      onPressed: () {
                        customLaunch('tel:+94 0776977939');
                      },
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone_in_talk,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            'Ambulance',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
