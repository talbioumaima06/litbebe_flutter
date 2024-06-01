import 'package:flutter/material.dart';
import 'package:litbebe/services/auth_service.dart';

class Parametre extends StatelessWidget {
  const Parametre({super.key});
  static const route = '/parametre';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signout(context: context);
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
