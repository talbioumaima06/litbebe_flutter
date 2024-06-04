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
        title: const Text('Smart Cradle'),
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
              'assets/images/parametre.png',
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
                        labelText: 'Ancien mot de passe',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre ancien mot de passe.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Nouveau mot de passe',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nouveau mot de passe.';
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
                      child: const Text('Mettre à jour le mot de passe'),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: GestureDetector(
                        onTap: _launchEmail, // Use the synchronous function
                        child: Text('support@example.com'),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: GestureDetector(
                        onTap: () => _makePhoneCall('1234567890'), // Wrap in a synchronous function
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

  // Synchronous function to launch email
  void _launchEmail() {
    _sendEmail('support@example.com'); // Call the asynchronous method
  }

  // Asynchronous method to launch email
  Future<void> _sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Support Request'
      }),
    );

    await launchUrl(emailLaunchUri);
  }

  // Utility method to encode query parameters
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Synchronous function to make a phone call
  void _makePhoneCall(String phoneNumber) {
    _callPhoneNumber(phoneNumber); // Call the asynchronous method
  }

  // Asynchronous method to make a phone call
  Future<void> _callPhoneNumber(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
