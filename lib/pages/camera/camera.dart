import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});
  static const route = '/camera';

  Future<void> _launchUrl() async {
    final DatabaseReference urlStreamingRef = FirebaseDatabase.instance.ref().child('/camera/url_streaming');
    final DatabaseEvent event = await urlStreamingRef.once();
    final String urlString = event.snapshot.value as String;

    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Cradle'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/camera1.jpg',
              height: 200,
              width: 200,
            ),
            TextButton(
              onPressed: _launchUrl,
              child: 
              Text("Cliquez ici pour surveiller votre bébé",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color:Colors.indigo[900]),),
            ),
          ],
        ),
      ),
    );
  }
}
