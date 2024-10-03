import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _profileImageUrl;

  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPhone = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _profileImageUrl = data['profileImage'];
        setState(() {});
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<String?> _uploadImageToStorage() async {
    if (_imageFile == null) return _profileImageUrl;

    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_${_imageFile!.name}';
      Reference reference = _storage.ref().child('seekerImages/$fileName');
      await reference.putFile(File(_imageFile!.path));
      return await reference.getDownloadURL();
    } catch (e) {
      print('Image upload failed: $e');
      return _profileImageUrl;
    }
  }

  Future<void> _saveProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String? imageUrl = await _uploadImageToStorage();
        await _firestore.collection('users').doc(user.uid).update({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'profileImage': imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile update failed: $e')),
      );
    }
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required Function onEdit,
    required Function onSave,
  }) {
    return Row(
      children: [
        Expanded(
          child: isEditing
              ? TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          )
              : Text('$label: ${controller.text}'),
        ),
        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit),
          onPressed: () {
            if (isEditing) {
              onSave();
            } else {
              onEdit();
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Stack(
        children: [
          Image.network(
            'https://onlineprofilepros.com/wp-content/uploads/2018/02/Career-Profile.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(File(_imageFile!.path))
                        : _profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!) as ImageProvider
                        : AssetImage('assets/default_avatar.png'),
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileField(
                  label: 'Name',
                  controller: _nameController,
                  isEditing: _isEditingName,
                  onEdit: () {
                    setState(() {
                      _isEditingName = true;
                    });
                  },
                  onSave: () {
                    setState(() {
                      _isEditingName = false;
                    });
                    _saveProfile();
                  },
                ),
                _buildProfileField(
                  label: 'Email',
                  controller: _emailController,
                  isEditing: _isEditingEmail,
                  onEdit: () {
                    setState(() {
                      _isEditingEmail = true;
                    });
                  },
                  onSave: () {
                    setState(() {
                      _isEditingEmail = false;
                    });
                    _saveProfile();
                  },
                ),
                _buildProfileField(
                  label: 'Phone',
                  controller: _phoneController,
                  isEditing: _isEditingPhone,
                  onEdit: () {
                    setState(() {
                      _isEditingPhone = true;
                    });
                  },
                  onSave: () {
                    setState(() {
                      _isEditingPhone = false;
                    });
                    _saveProfile();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text('Save Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
