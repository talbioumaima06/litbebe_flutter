import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});
  static const route = '/camera';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        actions: const [
          //IconButton(
          //onPressed: () async {
          // Implement sign out functionality here
          //},
          //icon: const Icon(
          //  Icons.logout,
          // size: 30,
          //),
          //color: Colors.white, // Change the color as per your design
          //),
        ],
        backgroundColor: const Color(0xFFB3CEDB), // Set the background color of the app bar
      ),
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Mjpeg(
              isLive: true, // Assuming the stream should start immediately
              stream: 'http://192.168.1.26',
            ),
          ],
        ),
      ),
    );
  }
}
