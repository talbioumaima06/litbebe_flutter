import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});
  static const route = '/camera';

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
              'assets/images/temperature-removebg-preview.png',
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
