import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:litbebe/services/auth_service.dart';

class Parametre extends StatelessWidget {
  const Parametre({Key? key}) : super(key: key);
  static const route = '/parametre';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _oldPasswordController = TextEditingController();
    final TextEditingController _newPasswordController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _oldPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Old Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, update password
                          await AuthService().updatePassword(
                            oldPassword: _oldPasswordController.text,
                            newPassword: _newPasswordController.text,
                            context: context,
                          );
                        }
                      },
                      child: const Text('Update Password'),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: GestureDetector(
                        onTap: _launchEmail, // Call the static method directly
                        child: Text('support@example.com'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: GestureDetector(
                        onTap: _launchPhone, // Call the static method directly
                        child: Text('+1234567890'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Static method to launch email
  static void _launchEmail() async {
    const email = 'mailto:support@example.com';
  }

  // Static method to launch phone call
  static void _launchPhone() async {
    const phoneNumber = '+1234567890';
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');
  }
}
