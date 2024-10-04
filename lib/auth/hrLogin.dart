import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HrLogin extends StatefulWidget {
  @override
  _HrLoginState createState() => _HrLoginState();
}

class _HrLoginState extends State<HrLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginHr() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      if (userDoc.exists && userDoc['role'] == 'HR') {
        Navigator.pushNamed(context, '/hrHome');
      } else {
        await _auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unauthorized access. Please log in as HR.")),
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
        title: Text('HR Login',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.cyan,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: loginHr,
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/hrRegistration');
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
