import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String ipAddress = '';
String output = '';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(output),
          TextField(
            onChanged: (value) => ipAddress = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter IP Address",
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 65),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                )),
            onPressed: () {
              saveData(ipAddress);
              output = ipAddress;
              setState(() {});
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}

void saveData(String ipAddress) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('IPADDRESS', ipAddress);
}
