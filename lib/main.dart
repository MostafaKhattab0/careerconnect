import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstp/project/auth/authSelection.dart';
import 'package:firstp/project/auth/hrLogin.dart';
import 'package:firstp/project/auth/hrRegistration.dart';
import 'package:firstp/project/auth/jopSeekerLogin.dart';
import 'package:firstp/project/auth/jobSeekerRegristration.dart';
import 'package:firstp/project/hr/hrHome.dart';
import 'package:firstp/project/hr/jobAdd.dart';
import 'package:firstp/project/hr/jobApplications.dart';
import 'package:firstp/project/hr/myJobs.dart';
import 'package:firstp/project/hr/viewJobSeekers.dart' as hr;
import 'package:firstp/project/hr/viewJobSeekers.dart' as jobseeker;
import 'package:firstp/project/jobseeker/jobSeekerHome.dart';
import 'package:firstp/project/jobseeker/jobListings.dart';
import 'package:firstp/project/jobseeker/appliedJobs.dart';
import 'package:firstp/project/jobseeker/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareerConnect App',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthSelection(),
        '/hrLogin': (context) => HrLogin(),
        '/hrRegistration': (context) => HrRegistration(),
        '/jobSeekerLogin': (context) => JobSeekerLogin(),
        '/jobSeekerRegistration': (context) => JobSeekerRegistration(),
        '/hrHome': (context) => HrHome(),
        '/jobAdd': (context) => JobAdd(),
        '/jobApplications': (context) => JobApplications(),
        '/myJobs': (context) => MyJobs(),
        '/viewJobSeekersHR': (context) => hr.ViewJobSeekers(),
        '/viewJobSeekersJobSeeker': (context) => jobseeker.ViewJobSeekers(),
        '/jobSeekerHome': (context) => JobSeekerHome(),
        '/jobListings': (context) => JobListings(),
        '/appliedJobs': (context) => AppliedJobs(),
        '/profile': (context) => ProfilePage(),
        'hrHome': (context) => AuthSelection(),
        '/authSelection': (context) => AuthSelection(),      },
    );
  }
}
