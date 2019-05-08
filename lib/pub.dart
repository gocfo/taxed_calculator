import 'package:flutter/material.dart';

class PubPage extends StatefulWidget {
  _PubPageState createState() => _PubPageState();
}

class _PubPageState extends State<PubPage> {
  final _taxedRate = 13.0;
  String _sumInput = '';
  String _unitInput = '';

  Widget _count(BuildContext context) {
    var sum = double.tryParse(_sumInput);
    var unit = double.tryParse(_unitInput);
    if ((sum == null) || (unit == null)) {
      return AlertDialog(content: Text("非法输入-非数字"));
    }
    if ((sum.toInt() <= 0) || (unit.toInt() <= 0)) {
      return AlertDialog(content: Text("无效输入-非法值"));
    }
    var bill = (sum / (_taxedRate / 100 + 1.0) * 100000).toInt() / 100000;
    var ton = (sum / unit * 10).toInt() / 10;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "价税合计: " + sum.toString(),
            style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
            child: Text(
              "税率: " + _taxedRate.toString() + "％",
              style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
            child: Text(
              "金额: " + bill.toString(),
              style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
            ),
          ),
          Text(
            "数量: " + ton.toString() + "（吨）",
            style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Widget _taxedRateTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "税率: " + _taxedRate.toString() + "％",
        labelStyle: TextStyle(fontSize: 26.0),
      ),
      enabled: false,
    );
  }

  Widget _unitTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "含税单价:",
          labelStyle: TextStyle(fontSize: 26.0),
        ),
        keyboardType: TextInputType.number,
        maxLines: 1,
        onChanged: (input) => setState(() => _unitInput = input),
      ),
    );
  }

  Widget _sumTextField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 30.0),
      child: TextField(
          decoration: InputDecoration(
            labelText: "价税合计:",
            labelStyle: TextStyle(fontSize: 26.0),
          ),
          keyboardType: TextInputType.number,
          maxLines: 1,
          onChanged: (input) => setState(() => _sumInput = input)),
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
        _taxedRateTextField(),
        _unitTextField(),
        _sumTextField(),
        _countButton(context),
      ],
    );
  }
}
