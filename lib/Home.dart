import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bmi.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseUser user;

  MyHomePage(this.user, {Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BmiPage(),
      debugShowCheckedModeBanner: false,
    );
  }
  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyLoginPage()),
        ModalRoute.withName('/'));
  }


}

