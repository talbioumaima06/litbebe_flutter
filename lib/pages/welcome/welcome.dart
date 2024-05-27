import 'package:flutter/material.dart';
import 'package:litbebe/pages/login/login.dart';
import 'package:litbebe/pages/signup/signup.dart';

class Welcome extends StatelessWidget {
    const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/baby_logo1-removebg-preview.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Overlay with buttons
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity as desired
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Your logo or decorative image
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Image.asset(
                      'assets/images/1000005708.jpg', // Replace with your image path
                      width: 150.0,
                      height: 150.0,
                    ),
                  ),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: const Text('Login'),
                  ),
                  // Signup Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: const Text('Signup'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

