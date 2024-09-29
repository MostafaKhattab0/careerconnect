import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppliedJobs extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    User? currentUser = _auth.currentUser;

    if (currentUser == null) {

      return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Applied Jobs")),
        body: Center(child: Text("Please log in to view applied jobs")),
      );
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Applied Jobs")),
      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance
            .collection('applications')
            .where('applicantId', isEqualTo: currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var jobs = snapshot.data!.docs;
          if (jobs.isEmpty) {
            return Center(child: Text("No jobs applied yet."));
          }

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              var job = jobs[index];
              return ListTile(
                title: Text(job['jobTitle']),
                subtitle: Text("Applied on ${job['createdAt'].toDate()}"),
              );
            },
          );
        },
      ),
    );
  }
}
