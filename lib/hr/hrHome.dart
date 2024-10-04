import 'package:flutter/material.dart';

class HrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "HR Home",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'http://tecc.co.in/files/img/hr1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  foregroundColor: Colors.deepPurple,
                  backgroundColor: Colors.cyan,
                ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/jobAdd');
                  },
                  child: Text("Add a Job",style:
                    TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 17
                    ),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    foregroundColor: Colors.cyan,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/jobApplications');
                  },
                  child: Text("View Job Applications",style:
                  TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan,
                      fontSize: 17
                  ),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    foregroundColor: Colors.deepPurple,
                    backgroundColor: Colors.cyan,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/viewJobSeekersHR');
                  },
                  child: Text("View Job Seekers",style:
                  TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 17
                  ),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    foregroundColor: Colors.deepPurple,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/myJobs');
                  },
                  child: Text("My Jobs",style:
                  TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan,
                      fontSize: 17
                  ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
