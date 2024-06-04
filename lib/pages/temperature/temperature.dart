import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class Temperature extends StatelessWidget {
  const Temperature({super.key});
  static const route = '/temperature';

  @override
  Widget build(BuildContext context) {
    final DatabaseReference temperatureRef = FirebaseDatabase.instance.ref().child('/Sensor/DHT_11/Temperature');
    final DatabaseReference humidityRef = FirebaseDatabase.instance.ref().child('/Sensor/DHT_11/Humidity');
    final message = ModalRoute.of(context)!.settings.arguments;
    print('messageeeeee: $message');

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
            StreamBuilder<DatabaseEvent>(
              stream: temperatureRef.onValue,
              builder: (context, snapshot) {
                print('Connection State: ${snapshot.connectionState}');
                print('Has Error: ${snapshot.hasError}');
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                }
                print('Has Data: ${snapshot.hasData}');
                print('Snapshot Data: ${snapshot.data?.snapshot.value}');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    'Chargement...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  double temperature = (snapshot.data!.snapshot.value as num).toDouble();
                  Color textColor = temperature > 37 ? Colors.red : Colors.black;
                  IconData? iconData = temperature > 37 ? Icons.warning : null;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Température: $temperature°C',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          if (iconData != null) Icon(iconData, color: Colors.red),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    'No data available',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                }
              },
            ),
            StreamBuilder<DatabaseEvent>(
              stream: humidityRef.onValue,
              builder: (context, snapshot) {
                print('Connection State: ${snapshot.connectionState}');
                print('Has Error: ${snapshot.hasError}');
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                }
                print('Has Data: ${snapshot.hasData}');
                print('Snapshot Data: ${snapshot.data?.snapshot.value}');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    'Chargement...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  double humidity = (snapshot.data!.snapshot.value as num).toDouble();
                  return Text(
                    'Humidité: $humidity',
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return const Text(
                    'No data available',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
