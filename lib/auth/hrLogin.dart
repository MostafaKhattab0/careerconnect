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

      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(userCredential.user!.uid).get();
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
        title: Text('HR Login',style:
        TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 22
        ),),
        backgroundColor:  Colors.cyan ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.network(
                'https://th.bing.com/th/id/OIP.PaTTyK3H5Iv0VaI0JdHwOQHaB0?rs=1&pid=ImgDetMain',
                height: 150,
                width: 450,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32),
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
                onPressed: loginHr,
                child: Text('Login',style:
                TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan,
                    fontSize: 18
                ),),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",style:
                  TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15
                  ),),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/hrRegistration');
                    },
                    child: Text('Register',style:
                    TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.cyan,
                        fontSize: 20
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
