import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyJobs extends StatefulWidget {
  @override
  _MyJobsState createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> myJobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMyJobs();
  }

  void fetchMyJobs() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {

        QuerySnapshot querySnapshot = await _firestore
            .collection('jobs')
            .where('hrEmail', isEqualTo: user.email)
            .get();

        setState(() {
          myJobs = querySnapshot.docs.map((doc) => {
            'jobId': doc.id,
            'title': doc['title'],
            'description': doc['description'],
            'createdAt': doc['createdAt'],
          }).toList();
          isLoading = false;
        });
      } catch (e) {
        print("Error fetching jobs: $e");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Jobs")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : myJobs.isEmpty
          ? Center(child: Text("No jobs found."))
          : ListView.builder(
        itemCount: myJobs.length,
        itemBuilder: (context, index) {
          final job = myJobs[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(job['title']),
              subtitle: Text(job['description']),
            ),
          );
        },
      ),
    );
  }
}
