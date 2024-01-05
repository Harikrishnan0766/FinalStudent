import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class student extends StatefulWidget {
  const student({super.key});

  @override
  State<student> createState() => _studentState();
}

// ignore: camel_case_types
class _studentState extends State<student> {
  final CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  TextEditingController studentName = TextEditingController();
  TextEditingController studentAge = TextEditingController();
  TextEditingController studentAddress = TextEditingController();
  TextEditingController studentPhone = TextEditingController();

  void addStudent() {
    final data = {
      'Name': studentName.text,
      'Age': studentAge.text,
      'Address': studentAddress.text,
      'Phone': studentPhone.text
    };
    students.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add student List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Name')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentAge,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Age')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Address')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Phone')),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (studentAddress.text.isNotEmpty &&
                      studentName.text.isNotEmpty &&
                      studentAge.text.isNotEmpty &&
                      studentPhone.text.isNotEmpty) {
                    addStudent();
                    Navigator.pop(context);
                  }
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text(
                  'submit',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
