import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  double _result = 0;
  String _operation = '';

  void _calculateResult() {
    double number1 = double.tryParse(_number1Controller.text) ?? 0;
    double number2 = double.tryParse(_number2Controller.text) ?? 0;

    setState(() {});
  }

  void _add() {
    double number1 = double.tryParse(_number1Controller.text) ?? 0;
    double number2 = double.tryParse(_number2Controller.text) ?? 0;

    setState(() {
      _result = number1 + number2;
    });
  }

  void _subtract() {
    double number1 = double.tryParse(_number1Controller.text) ?? 0;
    double number2 = double.tryParse(_number2Controller.text) ?? 0;

    setState(() {
      _result = number1 - number2;
    });
  }

  void _multiply() {
    double number1 = double.tryParse(_number1Controller.text) ?? 0;
    double number2 = double.tryParse(_number2Controller.text) ?? 0;

    setState(() {
      _result = number1 * number2;
    });
  }

  void _divide() {
    double number1 = double.tryParse(_number1Controller.text) ?? 0;
    double number2 = double.tryParse(_number2Controller.text) ?? 0;

    setState(() {
      if (number2 != 0) {
        _result = number1 / number2;
      } else {
        _result = double.infinity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 3')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _number1Controller,
              decoration: InputDecoration(labelText: 'Number 1'),
            ),
            TextField(
              controller: _number2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number 2'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Result: ${_result.isFinite ? _result : "Error"}',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _add();
                  },
                  child: Text('+'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _subtract();
                  },
                  child: Text('-'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _multiply();
                  },
                  child: Text('*'),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _divide();
                  },
                  child: Text('/'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
