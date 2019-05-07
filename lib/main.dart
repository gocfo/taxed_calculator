import 'package:flutter/material.dart';

void main() => runApp(HomePage());

String _billInput = '';
String _taxPointInput = '';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 30.0),
          child: CountPage(),
        ),
      ),
      theme: ThemeData.light(),
    );
  }
}

class CountPage extends StatelessWidget {
  Widget _count(BuildContext context) {
    var bill = double.tryParse(_billInput);
    var taxPoint = double.tryParse(_taxPointInput);
    if ((bill == null) || (taxPoint == null)) {
      return AlertDialog(content: Text("无效输入"));
    }
    if ((bill.toInt() <= 0) || (taxPoint.toInt() <= 0)) {
      return AlertDialog(content: Text("零值"));
    }
    if (taxPoint.toInt() >= 100) {
      return AlertDialog(content: Text("Point >= 100"));
    }
    var sum = ((bill / (100 - taxPoint)) * 100 * 100).toInt() / 100;
    return AlertDialog(
      content: Container(
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Text(
                "税点: " + taxPoint.toString(),
                style: TextStyle(color: Colors.blueAccent, fontSize: 30.0),
              ),
            ),
            Text(
              "货款: " + bill.toString(),
              style: TextStyle(color: Colors.lightGreen, fontSize: 30.0),
            ),
            Text(
              "税款: " + (((sum - bill) * 100).toInt() / 100).toString(),
              style: TextStyle(color: Colors.lightGreen, fontSize: 30.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: Text(
                "对公总额: " + sum.toString(),
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _billTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "货款:",
        labelStyle: TextStyle(fontSize: 26.0),
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      onChanged: (input) => _billInput = input,
    );
  }

  Widget _taxPointTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 30.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "税点:",
          labelStyle: TextStyle(fontSize: 26.0),
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        onChanged: (input) => _taxPointInput = input,
      ),
    );
  }

  Widget _countButton(BuildContext context) {
    return RaisedButton(
      textTheme: ButtonTextTheme.accent,
      child: Text('COUNT'),
      onPressed: () => showDialog(
            context: context,
            builder: _count,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _billTextField(),
          _taxPointTextField(),
          _countButton(context),
        ]);
  }
}
