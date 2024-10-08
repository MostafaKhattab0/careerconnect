import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HrRegistration extends StatefulWidget {
  @override
  _HrRegistrationState createState() => _HrRegistrationState();
}

class _HrRegistrationState extends State<HrRegistration> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  void registerHr() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'companyName': companyController.text.trim(),
        'role': 'HR',
      });

      Navigator.pushNamed(context, '/hrHome');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HR Registration',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: companyController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: registerHr,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
