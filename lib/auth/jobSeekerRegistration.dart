import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstp/project/jobseeker/jobSeekerHome.dart';

class JobSeekerRegistration extends StatefulWidget {
  @override
  _JobSeekerRegistrationState createState() => _JobSeekerRegistrationState();
}

class _JobSeekerRegistrationState extends State<JobSeekerRegistration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _register() async {
    try {
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _phoneController.text.isEmpty) {
        throw Exception("All fields must be filled.");
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Map<String, dynamic> userData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'role': 'job seeker',
        'phone': _phoneController.text.trim(),
      };

      await _firestore.collection('users').doc(userCredential.user!.uid).set(userData);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => JobSeekerHome()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Job Seeker Registration',style:
      TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 20
      ),
      ),
      backgroundColor: Colors.cyan,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name',labelStyle:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email',labelStyle:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password',labelStyle:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
              obscureText: true,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone',labelStyle:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register',style:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                  fontSize: 20
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
