import 'package:flutter/material.dart';

class CountPage extends StatefulWidget {
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  String _billInput = '';
  String _taxPointInput = '';

  Widget _count(BuildContext context) {
    var bill = double.tryParse(_billInput);
    var taxPoint = double.tryParse(_taxPointInput);
    if ((bill == null) || (taxPoint == null)) {
      return AlertDialog(content: Text("非法输入-非数字"));
    }
    if ((bill.toInt() <= 0) || (taxPoint.toInt() <= 0)) {
      return AlertDialog(content: Text("无效输入-非法值"));
    }
    if (taxPoint.toInt() >= 100) {
      return AlertDialog(content: Text("税点大于一百"));
    }
    var sum = ((bill / (100 - taxPoint)) * 100 * 100).toInt() / 100;
    var tax = ((sum - bill) * 100).toInt() / 100;
    return AlertDialog(
      content: Container(
        height: 180.0,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Text(
                "税点: " + taxPoint.toString() + "％",
                style: TextStyle(color: Colors.lightBlue, fontSize: 26.0),
              ),
            ),
            Text(
              "货款: " + bill.toString(),
              style: TextStyle(color: Colors.blueAccent, fontSize: 26.0),
            ),
            Text(
              "税款: " + tax.toString(),
              style: TextStyle(color: Colors.blueAccent, fontSize: 26.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: Text(
                "对公总额: " + sum.toString(),
                style: TextStyle(color: Colors.black, fontSize: 26.0),
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
      onChanged: (input) => setState(() => _billInput = input),
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
        onChanged: (input) => setState(() => _taxPointInput = input),
      ),
    );
  }

  Widget _countButton(BuildContext context) {
    return RaisedButton(
      textTheme: ButtonTextTheme.accent,
      child: Text(
        'LAUNCH',
        style: TextStyle(fontSize: 26),
      ),
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
      ],
    );
  }
}
