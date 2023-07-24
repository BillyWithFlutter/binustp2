import 'package:flutter/material.dart';

import '../user.dart';

class FormScreen extends StatefulWidget {
  static const routeName = '/form-profile';

  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();

  String name = '';
  String hobby = '';

  String appBarTitle = '';

  @override
  void dispose() {
    _nameController.dispose();
    _hobbyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchDataAndPopulateFields();
  }

  Future<void> fetchDataAndPopulateFields() async {
    Map<String, String> userData = await UserPreferences.fetchData();
    setState(() {
      _nameController.text = userData['name']!;
      _hobbyController.text = userData['hobby']!;
      appBarTitle = userData['name']!; // Update the AppBar title
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  appBarTitle,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextFormField(
                controller: _hobbyController,
                decoration: const InputDecoration(
                  labelText: 'Hobby',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your hobby';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    hobby = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await UserPreferences.addData(name, hobby);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted'),
                      ),
                    );

                    setState(() {
                      appBarTitle = name;
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
