import 'package:flutter/material.dart';
import 'package:car_license_exams/screens/home/components/main_menu.dart';

class MyAppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: '汽車駕照題庫練習');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // Fields in a Widget subclass are always marked "final".
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(80, 85, 111, 1))),
          elevation: 0.0,
          // backgroundColor: Color.fromRGBO(247, 249, 252, 1)
        ),
        drawer: Drawer(
            child: ListView(
          // Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0,
              child: DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(color: Colors.white),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(15.0)),
            ),
            ListTile(
                title: Text('保留位置 1'),
                onTap: () {
                  // update the state of app
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text('關於'),
                onTap: () {
                  // update the state of app
                  Navigator.pop(context);
                })
          ],
        )),
        body: Container(
            margin: EdgeInsets.only(
                left: 10.0, top: 15.0, right: 10.0, bottom: 15.0),
            child: MainMenuState()));
  }
}
