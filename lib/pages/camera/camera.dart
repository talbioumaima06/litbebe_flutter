import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});
  static const route = '/camera';

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late VlcPlayerController _vlcPlayerController;
  final String streamUrl = "http://<ESP32-CAM-IP>/stream"; // Replace with your ESP32-CAM IP

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(
      streamUrl,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    super.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/temperature-removebg-preview.png',
              height: 200,
              width: 200,
            ),
            Expanded(
              child: VlcPlayer(
                controller: _vlcPlayerController,
                aspectRatio: 16 / 9,
                placeholder: Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
