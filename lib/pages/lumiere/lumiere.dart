import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:firebase_database/firebase_database.dart';

class Lumiere extends StatefulWidget {
  const Lumiere({super.key});

  @override
  _LumiereState createState() => _LumiereState();
}

class _LumiereState extends State<Lumiere> {
  late DatabaseReference rgbRef;
  late DatabaseReference statusRef;
  Color currentColor = Colors.white; // Default color
  bool isLightOn = false; // Default status

  @override
  void initState() {
    super.initState();
    rgbRef = FirebaseDatabase.instance.ref().child('LED/RGB');
    statusRef = FirebaseDatabase.instance.ref().child('LED/status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        actions: const [
          // IconButton(
          //   onPressed: () async {
          //     // Implement sign out functionality here
          //   },
          //   icon: const Icon(
          //     Icons.logout,
          //     size: 30,
          //   ),
          //   color: Colors.white, // Change the color as per your design
          // ),
        ],
        backgroundColor: const Color(0xFFB3CEDB), // Set the background color of the app bar
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Image.asset(
              'assets/images/Bulb_Logo-removebg-preview.png',
              height: 200,
              width: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
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
              stream: rgbRef.onValue,
              builder: (context, snapshot) {
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
                  String rgb = snapshot.data!.snapshot.value as String;
                  List<String> rgbValues = rgb.split(',');
                  if (rgbValues.length == 3) {
                    try {
                      int red = int.parse(rgbValues[0]);
                      int green = int.parse(rgbValues[1]);
                      int blue = int.parse(rgbValues[2]);
                      Color newColor = Color.fromRGBO(red, green, blue, 1.0);
                      // Only update state if the color has actually changed
                      if (newColor != currentColor) {
                        Future.microtask(() {
                          setState(() {
                            currentColor = newColor;
                          });
                        });
                      }
                      print('RGB values: $red, $green, $blue');
                    } catch (e) {
                      print('Error parsing RGB values: $e');
                    }
                  } else {
                    print('Invalid RGB format: $rgb');
                  }
                  return Container(
                    height: 0, // Adjust as needed
                  );
                } else {
                  print('No data available for RGB');
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
            StreamBuilder<DatabaseEvent>(
              stream: statusRef.onValue,
              builder: (context, snapshot) {
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
                  bool newStatus = snapshot.data!.snapshot.value == 1;
                  // Only update state if the status has actually changed
                  if (newStatus != isLightOn) {
                    Future.microtask(() {
                      setState(() {
                        isLightOn = newStatus;
                      });
                    });
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Light is ${isLightOn ? 'On' : 'Off'}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Switch(
                        value: isLightOn,
                        onChanged: (newValue) {
                          statusRef.set(newValue ? 1 : 0);
                        },
                      ),
                    ],
                  );
                } else {
                  print('No data available for status');
                  return const Text(
                    'No data available for status',
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
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select LED Color:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  CircleAvatar(
                    backgroundColor: currentColor,
                    radius: 20.0,
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _showColorPicker(context);
                    },
                    child: const Text('Pick Color'),
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
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                setState(() {
                  currentColor = color;
                  String rgb = '${color.red},${color.green},${color.blue}';
                  rgbRef.set(rgb);
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
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
