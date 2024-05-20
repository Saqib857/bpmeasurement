import 'package:flutter/material.dart';

void main() {
  runApp(BloodPressureApp());
}

class BloodPressureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Pressure Measurement',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BloodPressureScreen(),
    );
  }
}

class BloodPressureScreen extends StatefulWidget {
  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  int systolicPressure = 120;
  int diastolicPressure = 80;
  String bloodPressureStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Measurement'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Systolic Pressure: $systolicPressure',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Diastolic Pressure: $diastolicPressure',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              bloodPressureStatus,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showDialog(context);
              },
              child: Text('Measure Blood Pressure'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Blood Pressure'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Systolic Pressure'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    systolicPressure = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Diastolic Pressure'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    diastolicPressure = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                _checkBloodPressure();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _checkBloodPressure() {
    if (systolicPressure > 130 || diastolicPressure > 80) {
      setState(() {
        bloodPressureStatus = 'High Blood Pressure!';
      });
    } else if (systolicPressure < 90 || diastolicPressure < 60) {
      setState(() {
        bloodPressureStatus = 'Low Blood Pressure!';
      });
    } else {
      setState(() {
        bloodPressureStatus = 'Normal Blood Pressure';
        });
    }
    }
}
