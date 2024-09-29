import 'package:flutter/material.dart';

class JobSeekerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Job Seeker Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobListings');
              },
              child: Text("View Job Listings"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/appliedJobs');
              },
              child: Text("View Applied Jobs"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text("View Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
