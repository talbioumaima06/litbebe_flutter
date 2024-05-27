import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:firebase_database/firebase_database.dart';

class Lumiere extends StatefulWidget {
  const Lumiere({Key? key}) : super(key: key);

  @override
  _LumiereState createState() => _LumiereState();
}

class _LumiereState extends State<Lumiere> {
  late DatabaseReference lightRef;
  late Color currentColor = Colors.white; // Default color

  @override
  void initState() {
    super.initState();
    lightRef = FirebaseDatabase.instance.ref().child('/LED/RGB'); // Adjust this path accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        actions: [
          IconButton(
            onPressed: () async {
              // Implement sign out functionality here
            },
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            color: Colors.white, // Change the color as per your design
          ),
        ],
        backgroundColor: const Color(0xFFB3CEDB), // Set the background color of the app bar
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Light Control',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            StreamBuilder<DatabaseEvent>(
              stream: lightRef.onValue,
              builder: (context, snapshot) {
                print('Connection State: ${snapshot.connectionState}');
                print('Has Error: ${snapshot.hasError}');
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                }
                print('Has Data: ${snapshot.hasData}');
                print('Snapshot Data: ${snapshot.data?.snapshot.value}');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  bool isLightOn = snapshot.data!.snapshot.value == 1; // Assuming 1 means light is on
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Light is ${isLightOn ? 'On' : 'Off'}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Switch(
                        value: isLightOn,
                        onChanged: (newValue) {
                          lightRef.set(newValue ? 1 : 0); // Update the database with new value
                        },
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    'No data available',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select LED Color:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  CircleAvatar(
                    backgroundColor: currentColor,
                    radius: 20.0,
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _showColorPicker(context);
                    },
                    child: Text('Pick Color'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                setState(() {
                  currentColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
