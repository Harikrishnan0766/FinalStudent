import 'package:flutter/material.dart';
import 'package:my_app/search.dart';
import 'package:my_app/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Myhome extends StatelessWidget {
  Myhome({super.key});
  final CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  void deletestudent(docId) {
    students.doc(docId).delete();
  }

  List<Map<String, dynamic>> stdlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Search(students: stdlist),
                ));
              },
              icon: Icon(Icons.search))
        ],
        title: const Text(
          'students',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const student()));
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: students.orderBy('Name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot studentssnap =
                    snapshot.data!.docs[index];
                stdlist.add({
                  'name': studentssnap['Name'].toString(),
                  'age': studentssnap['Age'].toString(),
                  'phone': studentssnap['Phone'].toString(),
                  'address': studentssnap['Address'].toString(),
                  'id': studentssnap.id
                });
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 209, 197, 197),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15,
                              spreadRadius: 20)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 40,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              studentssnap['Name'].toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              studentssnap['Age'].toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              studentssnap['Address'].toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              studentssnap['Phone'].toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Update',
                                    arguments: {
                                      'Name': studentssnap['Name'],
                                      'Age': studentssnap['Age'].toString(),
                                      'Address': studentssnap['Address'],
                                      'Phone': studentssnap['Phone'].toString(),
                                      'id': studentssnap.id,
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                              iconSize: 60,
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                                deletestudent(studentssnap.id);
                              },
                              icon: const Icon(Icons.delete),
                              iconSize: 60,
                              color: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
