import 'package:flutter/material.dart';
import 'package:litbebe/services/auth_service.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        automaticallyImplyLeading: false, // This removes the back button
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
      //drawer: const Drawer(
      //  elevation: 16,
        // Add your drawer content here
      //),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          DashboardGridWidget(
            image: 'assets/images/camera1.jpg',
            text: 'Camera',
            route: '/camera',
          ),
          DashboardGridWidget(
            image: 'assets/images/s0sy2_t.jpg',
            text: 'Temperature',
            route: '/temperature',
          ),
          DashboardGridWidget(
            image: 'assets/images/musique.jpg',
            text: 'Musique',
            route: '/music',
          ),
          //DashboardGridWidget(
          // image: 'assets/images/climatisation.jpg',
          // text: 'Climatisation',
          // route: '/climatisation',
          //),
          DashboardGridWidget(
            image: 'assets/images/Bulb_Logo-removebg-preview.png',
            text: 'Lumiére',
            route: '/lumiere',
          ),
          DashboardGridWidget(
            image: 'assets/images/swinng.jpg',
            text: 'Balancement',
            route: '/swing',
          ),
          DashboardGridWidget(
            image: 'assets/images/parametre.png',
            text: 'Paramétre',
            route: '/parametre',
          ),
        ],
      ),
    );
  }
}

class DashboardGridWidget extends StatelessWidget {
  final String image;
  final String text;
  final String route;

  const DashboardGridWidget({
    super.key,
    required this.image,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Removed const
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
