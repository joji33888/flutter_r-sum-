import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int _number = 0;

  void _incrementNumber() {
    setState(() {
      _number++;
    });
  }

  void _decrementNumber() {
    setState(() {
      _number--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Number: $_number', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_number < 0)
                  Row(
                    children: [
                      Text('Warning', style: TextStyle(color: Colors.red)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.warning, color: Colors.red),
                      ),
                    ],
                  ),
                if (_number > 0)
                  Row(
                    children: [
                      Text(
                        'Not like your grads',
                        style: TextStyle(color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.check, color: Colors.green),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: _incrementNumber, child: Text('+')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: _decrementNumber, child: Text('-')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
