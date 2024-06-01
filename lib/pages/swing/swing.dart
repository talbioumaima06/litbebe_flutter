import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Swing extends StatefulWidget {
  const Swing({super.key});
  static const route = '/swing';

  @override
  _SwingState createState() => _SwingState();
}

class _SwingState extends State<Swing> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('Swings');
  bool _isSwingOn = false;

  @override
  void initState() {
    super.initState();
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is bool) {
        setState(() {
          _isSwingOn = data;
        });
      }
    });
  }

  void _toggleSwitch(bool value) {
    _databaseReference.set(value);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/swinng.jpg',
              height: 200,
              width: 200,
            ),
            SwitchListTile(
              title: const Text('Swing Status'),
              value: _isSwingOn,
              onChanged: _toggleSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
