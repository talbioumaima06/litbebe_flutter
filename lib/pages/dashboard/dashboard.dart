import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> gridItems = [
      {'image': 'assets/images/camera1.jpg', 'text': 'Camera', 'route': '/camera'},
      {'image': 'assets/images/s0sy2_t.jpg', 'text': 'Temperature', 'route': '/temperature'},
      {'image': 'assets/images/musique.jpg', 'text': 'Musique', 'route': '/music'},
      {'image': 'assets/images/climatisation.jpg', 'text': 'Climatisation', 'route': '/climatisation'},
      {'image': 'assets/images/Bulb_Logo-removebg-preview.png', 'text': 'Lumiére', 'route': '/lumiere'},
      {'image': 'assets/images/swinng.jpg', 'text': 'Balancement', 'route': '/swing'},
      {'image': 'assets/images/parametre.png', 'text': 'Paramétre', 'route': '/parametre'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Name'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     'Hello👋',
            //     style: GoogleFonts.raleway(
            //       textStyle: const TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     FirebaseAuth.instance.currentUser!.email!,
            //     style: GoogleFonts.raleway(
            //       textStyle: const TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16), // Adjust padding
                childAspectRatio: 0.8, // Adjust aspect ratio to control item size
                mainAxisSpacing: 8, // Add spacing between rows
                crossAxisSpacing: 8, // Add spacing between columns
                children: List.generate(
                  gridItems.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, gridItems[index]['route']!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              gridItems[index]['image']!,
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              gridItems[index]['text']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xff0D6EFD),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //       minimumSize: const Size(double.infinity, 60),
            //       elevation: 0,
            //     ),
            //     onPressed: () async {
            //       await AuthService().signout(context: context);
            //     },
            //     child: const Text("Sign Out"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
