import 'package:flutter/material.dart';

class JobSeekerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Job Seeker Home",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white70,
        actions: [
          IconButton(
            iconSize: 38,
            icon: Icon(Icons.person_pin, color: Colors.cyan),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
                minHeight: 400,
              ),
              child: Image.network(
                'https://2.bp.blogspot.com/-jGfUbZBDqJg/WZGM8m0EcFI/AAAAAAAAE3U/8zf7JyfebOoBBqdWtQ_W0ODWnwYGxqt4gCLcBGAs/s1600/shutterstock_606904901.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Job Listings button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/jobListings');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        foregroundColor: Colors.deepPurple,
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        "View Job Listings",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/appliedJobs');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        foregroundColor: Colors.deepPurple,
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        "View Applied Jobs",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
