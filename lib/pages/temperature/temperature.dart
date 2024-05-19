import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);
  static const route = '/temperature';

  @override
  Widget build(BuildContext context) {
    final DatabaseReference temperatureRef = FirebaseDatabase.instance.ref().child('temperature');
    final message = ModalRoute.of(context)!.settings.arguments;
    print('messageeeeee: ${message}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
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
                    'Loading...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    'Error loading data',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  double temperature = (snapshot.data!.snapshot.value as num).toDouble();
                  return Text(
                    'Temperature: $temperature°C',
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
            Text(
              'Humidity: 60.0%',
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Change Temperature'),
                      content: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('You can switch on and off the climatisation sensor.'),
                          SizedBox(height: 10),
                          Text('Temperature Control:'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Change Temperature'),
            ),
          ],
        ),
      ),
    );
  }
}
