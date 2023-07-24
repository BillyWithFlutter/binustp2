import 'package:flutter/material.dart';

import '../user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appBarTitle = '';

  @override
  void initState() {
    super.initState();
    fetchDataAndPopulateFields();
  }

  Future<void> fetchDataAndPopulateFields() async {
    Map<String, String> userData = await UserPreferences.fetchData();
    setState(() {
      appBarTitle = userData['name'] ??
          ''; // Update the AppBar title with a fallback value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center the content horizontally
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                appBarTitle,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Selamat datang!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
