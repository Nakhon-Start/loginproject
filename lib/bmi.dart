import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculate'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () {
                signOut(context);
              })
        ],
      ),
      body: new ListView(
        padding: const EdgeInsets.all(3.5),
        children: <Widget>[
          new Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(5.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextField(
                  controller: _heightFieldController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      labelText: 'Height in feet(M)', icon: new Icon(Icons.info)),
                ),
                new TextField(
                  controller: _weightFieldController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      labelText: 'Weight in Pounds(Kg)',
                      icon: new Icon(Icons.shutter_speed)),
                ),
                new Padding(padding: const EdgeInsets.all(7.5)),
                new RaisedButton(
                  onPressed: _calculateMBI,
                  child: new Text(
                    'CALCULATE',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  color: Colors.lightGreenAccent,
                  textColor: Colors.blueGrey,
                ),
              ],
            ),
          ),
          new Padding(padding: const EdgeInsets.all(5.5)),
          new Container(
            alignment: Alignment.topCenter,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  _calcResult != null ? '$_calcResult' : '',
                  style: new TextStyle(
                      color: Colors.green,
                      fontSize: 44.5,
                      fontWeight: FontWeight.w800
                  ),
                ),
                new Text(_result != null ? _result: '',
                style: new TextStyle(
                  fontSize: 28.0,color: Colors.lightGreen
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }

  double _calculation;
  String _calcResult;
  String _result;

  TextEditingController _heightFieldController = new TextEditingController();
  TextEditingController _weightFieldController = new TextEditingController();

  void _calculateMBI() {
    double height = double.parse(_heightFieldController.text);
    double weight = double.parse(_weightFieldController.text);

    if (height != null || weight != null) {
      setState(() {
        _calculation = (weight / (height * height));
        _calcResult = _calculation.toStringAsFixed(2);
        if (_calculation < 18.5) {
          _result = 'UNDERWEIGHT';
        } else if (_calculation >= 18.5 && _calculation <= 24.9) {
          _result = 'GOOD FIT';
        } else if (_calculation >= 25.0 && _calculation <= 29.9) {
          _result = 'OVERWEIGHT';
        } else {
          _result = 'OBESE';
        }
      });
    }
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyLoginPage()),
        ModalRoute.withName('/'));
  }
}
