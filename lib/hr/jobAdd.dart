import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobAdd extends StatelessWidget {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  String jobType = 'Full-time';

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add a Job",style:
        TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),
      ),
      backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              _buildTextField(jobTitleController, "Job Title", "Enter the job title",),
              SizedBox(height: 25),
              _buildTextField(jobDescriptionController, "Job Description", "Enter the job description"),
              SizedBox(height: 25),
              _buildTextField(companyController, "Company", "Enter the company name"),
              SizedBox(height: 25),
              _buildTextField(locationController, "Location", "Enter the job location"),
              SizedBox(height: 25),
              _buildTextField(salaryController, "Salary (optional)", "Enter the salary range"),
              SizedBox(height: 25),
              _buildDropdown(),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (currentUser != null) {
                    try {
                      await FirebaseFirestore.instance.collection('jobs').add({
                        'title': jobTitleController.text,
                        'description': jobDescriptionController.text,
                        'company': companyController.text,
                        'location': locationController.text,
                        'salary': salaryController.text,
                        'jobType': jobType,
                        'hrEmail': currentUser.email,
                        'createdAt': DateTime.now(),
                      });
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error: $e");
                    }
                  }
                },
                child: Text("Post Job",style:
                  TextStyle(
                    color: Colors.cyan
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: jobType,
      items: <String>['Full-time', 'Part-time', 'Contract', 'Internship', 'Remote']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        jobType = newValue!;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Job Type",
      ),
    );
  }
}
