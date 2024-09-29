import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobAdd extends StatelessWidget {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add a Job")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 25),
            TextFormField(
              controller: jobTitleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Job Title",
                hintText: "Enter the job title",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: jobDescriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Job Description",
                hintText: "Enter the job description",
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                if (currentUser != null) {
                  try {
                    await FirebaseFirestore.instance.collection('jobs').add({
                      'title': jobTitleController.text,
                      'description': jobDescriptionController.text,
                      'hrEmail': currentUser.email,
                      'createdAt': DateTime.now(),
                    });
                    Navigator.pop(context);
                  } catch (e) {

                  }
                }
              },
              child: Text("Post Job"),
            ),
          ],
        ),
      ),
    );
  }
}
