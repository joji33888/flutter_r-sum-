import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String verificationResult = '';
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    Color resultColor = Colors.black;
    IconData resultIcon = Icons.info;

    if (verificationResult == 'You are underage.') {
      resultColor = Colors.red;
      resultIcon = Icons.cancel;
    } else if (verificationResult == 'Verification Success!') {
      resultColor = Colors.green;
      resultIcon = Icons.check_circle;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign-in',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: familyNameController,
                    decoration: InputDecoration(labelText: 'Family Name'),
                  ),
                  TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth (DD/MM/YYYY)',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Verify age
                      if (selectedDate == null) {
                        setState(() {
                          verificationResult = 'Please select a date of birth.';
                        });
                        return;
                      }
                      DateTime currentDate = DateTime.now();
                      int age = currentDate.year - selectedDate!.year;

                      if (currentDate.month < selectedDate!.month ||
                          (currentDate.month == selectedDate!.month &&
                              currentDate.day < selectedDate!.day)) {
                        age--;
                      }

                      setState(() {
                        if (age < 18) {
                          verificationResult = 'You are underage.';
                        } else {
                          verificationResult = 'Verification Success!';
                        }
                      });
                    },
                    child: Text('Verify'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(resultIcon, color: resultColor),
                      SizedBox(width: 5),
                      Text(
                        verificationResult,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: resultColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
