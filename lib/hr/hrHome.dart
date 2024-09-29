import 'package:flutter/material.dart';

class HrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("HR Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobAdd');
              },
              child: Text("Add a Job"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobApplications');
              },
              child: Text("View Job Applications"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewJobSeekersHR');
              },
              child: Text("View Job Seekers"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/myJobs');
              },
              child: Text("My Jobs"),
            ),
          ],
        ),
      ),
    );
  }
}
