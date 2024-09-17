import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  final String studentCode;
  final String fullName;
  final String phoneNumber;
  final String email;

  EditProfileView({
    required this.studentCode,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _studentCodeController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _studentCodeController.text = widget.studentCode;
    _fullNameController.text = widget.fullName;
    _phoneNumberController.text = widget.phoneNumber;
    _emailController.text = widget.email;
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          final response = await http.post(
            Uri.parse('https://your-api-url.com/api/updateProfile'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'studentCode': _studentCodeController.text,
              'fullName': _fullNameController.text,
              'phoneNumber': _phoneNumberController.text,
              'email': _emailController.text,
              'password': _passwordController.text,
            }),
          );

          if (response.statusCode == 200) {
            print('Profile updated successfully!');
            Navigator.pop(context);
          } else {
            print('Failed to update profile');
          }
        } catch (e) {
          print('Error updating profile: $e');
        }
      } else {
        print('Passwords do not match!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _studentCodeController,
                decoration: InputDecoration(labelText: 'Student Code'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your student code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
