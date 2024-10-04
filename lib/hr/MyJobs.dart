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

  void deleteJob(String jobId) async {
    try {
      await _firestore.collection('jobs').doc(jobId).delete();
      setState(() {
        myJobs.removeWhere((job) => job['jobId'] == jobId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Job deleted successfully!')),
      );
    } catch (e) {
      print("Error deleting job: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting job')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Jobs",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
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
            color: Colors.cyan, 
            child: ListTile(
              title: Text(
                job['title'],
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                job['description'],
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  deleteJob(job['jobId']);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
