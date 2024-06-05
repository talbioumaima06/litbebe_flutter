import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
final Uri _url=Uri.parse('http://192.168.1.26');

class Camera extends StatelessWidget {
  const Camera({super.key});
  static const route = '/camera';

  Future<void> _launchUrl()async {
    if (!await launchUrl(_url)){
      throw 'Could not launch $_url';
    }
  }

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: TextButton(
          onPressed: _launchUrl,
          child: 
          Text("Cliquez ici pour surveiller votre bébé",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color:Colors.indigo[900]),),
        ),
      ),
    );
  }
}
