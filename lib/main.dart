import 'package:careerconnect/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/authSelection.dart';
import 'auth/hrLogin.dart';
import 'auth/hrRegistration.dart';
import 'auth/jobSeekerLogin.dart';
import 'auth/jobSeekerRegistration.dart';
import 'hr/hrHome.dart';
import 'hr/jobAdd.dart';
import 'hr/jobApplications.dart';
import 'hr/myJobs.dart';
import 'hr/viewJobSeekers.dart' as hr;
import 'hr/viewJobSeekers.dart' as jobseeker;
import 'jobseeker/jobSeekerHome.dart';
import 'jobseeker/jobListings.dart';
import 'jobseeker/appliedJobs.dart';
import 'jobseeker/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareerConnect App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/authSelection': (context) => AuthSelection(),
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
      },
    );
  }
}
