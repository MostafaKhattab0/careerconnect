import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewJobSeekers extends StatefulWidget {
  @override
  _ViewJobSeekersState createState() => _ViewJobSeekersState();
}

class _ViewJobSeekersState extends State<ViewJobSeekers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> jobSeekers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchJobSeekers();
  }

  void fetchJobSeekers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'job seeker')
          .get();

      print('Number of job seekers: ${snapshot.docs.length}');

      setState(() {
        jobSeekers = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        loading = false;
      });
    } catch (e) {
      print('Error fetching job seekers: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Job Seekers")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : jobSeekers.isEmpty
          ? Center(child: Text("No job seekers found."))
          : ListView.builder(
        itemCount: jobSeekers.length,
        itemBuilder: (context, index) {
          final seeker = jobSeekers[index];


          String displayName = seeker['name'] ?? "Unknown";

          return ListTile(
            title: Text(displayName),
            subtitle: Text(seeker['email'] ?? "No email"),
          );
        },
      ),
    );
  }
}
