import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobListings extends StatefulWidget {
  @override
  _JobListingsState createState() => _JobListingsState();
}

class _JobListingsState extends State<JobListings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String applicantName = "Anonymous";
  String applicantEmail = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            applicantName = userDoc['name'] ?? "Anonymous";
            applicantEmail = userDoc['email'] ?? currentUser.email!;
            isLoading = false;
          });
        } else {
          setState(() {
            applicantName = currentUser.displayName ?? "Anonymous";
            applicantEmail = currentUser.email ?? "No Email";
            isLoading = false;
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Job Listings")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Job Listings")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var jobs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              var job = jobs[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(job['description'], style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text("Posted by: ${job['hrEmail']}", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseFirestore.instance.collection('applications').add({
                              'jobTitle': job['title'],
                              'applicantId': _auth.currentUser!.uid,
                              'applicantName': applicantName,
                              'applicantEmail': applicantEmail,
                              'createdAt': Timestamp.now(),
                              'jobId': job.id,
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Applied to ${job['title']} successfully")),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to apply for ${job['title']}")),
                            );
                          }
                        },
                        child: Text("Apply"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
