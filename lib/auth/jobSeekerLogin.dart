import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobSeekerLogin extends StatefulWidget {
  @override
  _JobSeekerLoginState createState() => _JobSeekerLoginState();
}

class _JobSeekerLoginState extends State<JobSeekerLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginJobSeeker() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      if (userDoc.exists && userDoc['role'] == 'job seeker') {
        Navigator.pushNamed(context, '/jobSeekerHome');
      } else {
        await _auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unauthorized access. Please log in as a job seeker.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Seeker Login',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Image.network(
              'https://thumbs.dreamstime.com/b/abstract-job-search-background-vector-illustration-design-abstract-job-search-background-vector-illustration-design-banners-251243471.jpg',
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email',labelStyle:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password',labelStyle:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: loginJobSeeker,
              child: Text('Login',style:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobSeekerRegistration');
              },
              child: Text('Register as Job Seeker', style: TextStyle(color: Colors.cyan)),
            ),
          ],
        ),
      ),
    );
  }
}
