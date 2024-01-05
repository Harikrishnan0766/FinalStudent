import 'package:flutter/material.dart';
import 'package:my_app/student.dart';

class Search extends StatefulWidget {
  Search({super.key, required this.students});
  List<Map<String, dynamic>> students = [];

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchText = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextFormField(
        onChanged: (value) {
           seaarchForStudent();
          setState(() {});
        },
        controller: searchText,
      )),
      body: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResult[index]['name'].toString()
            ,
            ),
            
          );
        },
      ),
    );
  }

  seaarchForStudent() {
   
    if (searchText.text.isNotEmpty) {
      searchResult = widget.students
          .where(
              (element) => element['name'].toString().contains(searchText.text),
              )
          .toList();
    } else {
      searchResult = widget.students;
    }
    
  }
}
