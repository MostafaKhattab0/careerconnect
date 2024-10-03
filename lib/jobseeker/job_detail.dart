import 'package:flutter/material.dart';

class JobDetail extends StatelessWidget {
  final String title;
  final String description;
  final String company;
  final String location;
  final String salary;
  final String hrEmail;

  JobDetail({
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.salary,
    required this.hrEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Company: $company',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 4),
            Text(
              'Location: $location',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 4),
            Text(
              'Salary: $salary',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Posted by: $hrEmail',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
