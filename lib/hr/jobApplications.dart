import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstp/project/hr/JobSeekerDetails.dart'; // Import the JobSeekerDetails screen

class JobApplications extends StatefulWidget {
  @override
  _JobApplicationsState createState() => _JobApplicationsState();
}

class _JobApplicationsState extends State<JobApplications> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> applications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobApplications();
  }

  void fetchJobApplications() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        QuerySnapshot jobsSnapshot = await _firestore.collection('jobs')
            .where('hrEmail', isEqualTo: user.email)
            .get();

        List<String> jobIds = jobsSnapshot.docs.map((doc) => doc.id).toList();
        if (jobIds.isNotEmpty) {
          QuerySnapshot applicationsSnapshot = await _firestore.collection('applications')
              .where('jobId', whereIn: jobIds)
              .get();
          setState(() {
            applications = applicationsSnapshot.docs.map((doc) => {
              'jobId': doc['jobId'],
              'jobTitle': doc['jobTitle'],
              'applicantName': doc['applicantName'],
              'applicantId': doc['applicantId'],
              'applicantEmail': doc['applicantEmail'],
              'createdAt': doc['createdAt'],
              'applicationId': doc.id, // Store application ID for deletion
            }).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            applications = [];
            isLoading = false;
          });
        }
      } catch (e) {
        print("Error fetching applications: $e");
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

  void deleteApplication(String applicationId) async {
    try {
      await _firestore.collection('applications').doc(applicationId).delete();
      setState(() {
        applications.removeWhere((application) => application['applicationId'] == applicationId);
      });
    } catch (e) {
      print("Error deleting application: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Applications", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : applications.isEmpty
          ? Center(child: Text("No applications found."))
          : ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final application = applications[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.cyan,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobSeekerDetails(
                            applicantName: application['applicantName'],
                            applicantEmail: application['applicantEmail'],
                            applicantId: application['applicantId'],
                            jobTitle: application['jobTitle'],
                            createdAt: application['createdAt'].toDate(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Applicant: ${application['applicantName']}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    "Job Title: ${application['jobTitle']}\nEmail: ${application['applicantEmail']}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Applied on: ${application['createdAt'].toDate()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobSeekerDetails(
                              applicantName: application['applicantName'],
                              applicantEmail: application['applicantEmail'],
                              applicantId: application['applicantId'],
                              jobTitle: application['jobTitle'],
                              createdAt: application['createdAt'].toDate(),
                            ),
                          ),
                        );
                      },
                      child: Text("Contact"),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        deleteApplication(application['applicationId']);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
