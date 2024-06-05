import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Music extends StatefulWidget {
  const Music({super.key});
  static const route = '/music';

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  String? dropdownValue;
  String? state;
  var items = ["Rock-A-Bye Baby", "Twinkle Twinkle Little Star", "Hush Little Baby"];

  @override
  void initState() {
    super.initState();
  }

  void setSong(String dropdownValue, String state) async {
    try {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      String? tok = await storage.read(key: "token");
      String? d_id = await storage.read(key: "device_id");

      if (tok == null || d_id == null) {
        _showAlertDialog(context, 'Error', 'Token or Device ID is null');
        return;
      }

      final response = await http.post(
        Uri.parse('http://10.30.84.209:9000/song'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tok'
        },
        body: jsonEncode(<String, String>{
          'device_id': d_id,
          'song': dropdownValue,
          'state': state,
        }),
      );

      if (response.statusCode == 200) {
        print("Successful");
      } else if (response.statusCode == 400) {
        _showAlertDialog(context, 'Invalid Inputs!', 'Some problem with inputs');
      } else if (response.statusCode == 402) {
        _showAlertDialog(context, 'Invalid Inputs!', 'WRONG INPUT');
      } else if (response.statusCode == 403) {
        _showAlertDialog(context, 'Invalid Inputs!', 'You have not this Device ID');
      } else {
        throw Exception('Failed to create album.');
      }
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Jouez de la musique pour votre bébé...",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            Image.asset(
              'assets/images/musique.jpg',
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 63),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue[50],
                  border: Border.all(),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  hint: Text(
                    "Sélectionnez une chanson",
                    style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  iconEnabledColor: Colors.blue[900],
                  isExpanded: true,
                  dropdownColor: Colors.blue[50],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  color: Colors.green[900],
                  icon: const Icon(Icons.play_circle),
                  onPressed: () {
                    if (dropdownValue != null) {
                      state = 'start';
                      setSong(dropdownValue!, state!);
                    } else {
                      _showAlertDialog(context, 'No Song Selected', 'Please select a song to play.');
                    }
                  },
                ),
                IconButton(
                  iconSize: 65,
                  color: Colors.red[900],
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    if (dropdownValue != null) {
                      state = 'stop';
                      setSong(dropdownValue!, state!);
                    } else {
                      _showAlertDialog(context, 'No Song Selected', 'Please select a song to stop.');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
