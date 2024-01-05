import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  TextEditingController studentName = TextEditingController();
  TextEditingController studentAge = TextEditingController();
  TextEditingController studentAddress = TextEditingController();
  TextEditingController studentPhone = TextEditingController();
  void updatesstudent(docId) {
    final data = {
      'Name': studentName.text,
      'Age': studentAge.text,
      'Address': studentAddress.text,
      'Phone': studentPhone.text,
    };
    students.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    studentName.text = args['Name'];
    studentAge.text = args['Age'].toString();
    studentAddress.text = args['Address'];
    studentPhone.text = args['Phone'].toString();
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update student',
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
                    border: OutlineInputBorder(), label: Text('name')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentAge,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('age')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('address')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: studentPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('phone')),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  updatesstudent(docId);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 43, 247, 2))),
                child: const Text(
                  'update',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
