import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Music extends StatefulWidget {
  const Music({super.key});
  static const route = '/music';

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  String? dropdownValue;
  List<String> items = [];
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    fetchPlaylist();
    fetchCurrentPlaying();
    listenToPlayingStatus();
  }

  Future<void> fetchPlaylist() async {
    DataSnapshot snapshot = await databaseRef.child('music/playlist').get();
    if (snapshot.exists) {
      String playlist = snapshot.value as String;
      setState(() {
        items = playlist.split(',');
      });
    }
  }

  Future<void> fetchCurrentPlaying() async {
    DataSnapshot snapshot = await databaseRef.child('music/current_playing').get();
    if (snapshot.exists) {
      String currentPlaying = snapshot.value as String;
      setState(() {
        dropdownValue = currentPlaying;
      });
    }
  }

  void listenToPlayingStatus() {
    databaseRef.child('music/playing').onValue.listen((event) {
      if (event.snapshot.exists) {
        int playingStatus = event.snapshot.value as int;
        setState(() {
          isPlaying = playingStatus == 1;
        });
      }
    });
  }

  void setSong(String song, String state) async {
    try {
      await databaseRef.child('music/playing').set(state == 'start' ? 1 : 0);
      if (state == 'start') {
        await databaseRef.child('music/current_playing').set(song);
      }
    } on Exception catch (e) {
      _showAlertDialog(context, 'Error', e.toString());
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
        backgroundColor: const Color(0xFFB3CEDB),
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
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
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
            Text(
              isPlaying
                  ? 'Playing: ${dropdownValue ?? 'No song selected'}'
                  : 'Music is stopped',
              style: TextStyle(
                fontSize: 18,
                color: isPlaying ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
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
                      setSong(dropdownValue!, 'start');
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
                      setSong(dropdownValue!, 'stop');
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
