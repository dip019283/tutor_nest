import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutornest/models/studentModel.dart';
import 'package:tutornest/models/userModel.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:email_otp/email_otp.dart';
import 'package:tutornest/pages/otp_page_register.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String gender = 'Male';
  bool _isPasswordVisible = false;
  bool _isReTypePasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reTypePasswordController =
  TextEditingController();

  String? _selectedCountry;

  final List<String> _countries = [
    "USA",
    "Canada",
    "United Kingdom",
    "Australia",
    "Germany",
    "France",
    "India",
    "China",
    "Japan",
    "Brazil",
  ];

  void sendOTP()async{
    EmailOTP.config(
      appName: 'TutorNest',
      otpType: OTPType.numeric,
      expiry : 60000,
      emailTheme: EmailTheme.v1,
      appEmail: 'tutornest.customercare@gmail.com',
      otpLength: 6,
    );
    bool result = await EmailOTP.sendOTP(email: _emailController.text);
    if(result){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(userEmail:_emailController.text)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong while sending OTP'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        QuerySnapshot emailExists = await _firestore
            .collection('users')
            .where('email', isEqualTo: _emailController.text)
            .get();

        QuerySnapshot usernameExists = await _firestore
            .collection('students')
            .where('username', isEqualTo: _usernameController.text)
            .get();

        if (emailExists.docs.isNotEmpty) {
          throw Exception("Email already in use.");
        }

        if (usernameExists.docs.isNotEmpty) {
          throw Exception("Username already in use.");
        }

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String userId = userCredential.user!.uid;

        String hashedPassword = BCrypt.hashpw(_passwordController.text, BCrypt.gensalt());

        UserModel user = UserModel(
          userId: userId,
          email: _emailController.text,
          password: hashedPassword,
          userRole: 'student',
        );

        await _firestore.collection('users').doc(user.userId).set(user.toFirestore());

        Student student = Student(
          studentId: userId,
          username: _usernameController.text,
          address: _addressController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          country: _selectedCountry,
          gender: gender,
        );

        await _firestore.collection('students').doc(student.studentId).set(student.toFirestore());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Student registered successfully")),
        );
        sendOTP();
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }





  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _reTypePasswordController.dispose();
    super.dispose();
  }

  Widget _buildCountryDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCountry,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.flag),
          labelText: _selectedCountry == null ? "Country" : null,
          floatingLabelBehavior: _selectedCountry == null
              ? FloatingLabelBehavior.auto
              : FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
        items: _countries
            .map(
              (country) => DropdownMenuItem<String>(
            value: country,
            child: Text(country),
          ),
        )
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedCountry = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your country';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: Text("Male", style: TextStyle(color: Colors.white)),
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  activeColor: Colors.blue,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title:
                  Text("Female", style: TextStyle(color: Colors.white)),
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  activeColor: Colors.blue,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: registerUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding:
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: "Username",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.home),
              hintText: "Address",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: "Phone Number",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [
            ],
          ),
          const SizedBox(height: 15),
          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: "Email",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          // Country Dropdown
          _buildCountryDropdown(),
          const SizedBox(height: 15),
          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: "Password",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _reTypePasswordController,
            obscureText: !_isReTypePasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Re-Type Password",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isReTypePasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isReTypePasswordVisible =
                    !_isReTypePasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please re-type your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          // Gender Selection
          _buildGenderSelection(),
          const SizedBox(height: 20),
          // Register Button
          _buildRegisterButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
      true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/register_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          // Title
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: _buildRegistrationForm(),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
