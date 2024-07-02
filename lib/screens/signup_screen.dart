import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../consts.dart';
import '../models/models.dart';
import '../services.dart';

import 'user_home.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();
  var nameTextController = TextEditingController();
  var numberTextController = TextEditingController();
  var addressTextController = TextEditingController();
  bool isVisible = true;
  bool confirmIsVisible = true;
  final ApiService apiService = ApiService();

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      RegisterRequest registerRequest = RegisterRequest(
        email: emailTextController.text,
        password: passwordTextController.text,
        confirmPassword: confirmPasswordTextController.text,
        userName: nameTextController.text,
        phoneNumber: numberTextController.text,
        address: addressTextController.text
      );

      try {
        AuthResponseRegister response = await apiService.registerUser(registerRequest);
        // String token = response.token;
        // Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
        // userId = decodedToken["id"];
        // Navigate to the next screen or show a success message
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } catch (e) {
        // Show error message
        print('Signup failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Signup failed: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Replace with your color constant
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    const Text(
                      "Signup",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], // Replace with your color constant
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        controller: nameTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Name",
                          suffixIcon: Icon(Icons.person_outline),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], // Replace with your color constant
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        controller: numberTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your phone number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Phone",
                          suffixIcon: Icon(Icons.phone),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], // Replace with your color constant
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        controller: emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Email";
                          }
                          final bool isValid = EmailValidator.validate(emailTextController.text);
                          if (!isValid) {
                            return "Email was entered incorrectly";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                          suffixIcon: Icon(Icons.email_outlined),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], // Replace with your color constant
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        controller: addressTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Address";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Address",
                          suffixIcon: Icon(Icons.home_rounded),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], // Replace with your color constant
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        obscureText: isVisible,
                        controller: passwordTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                            color: isVisible ? Colors.grey : kPrimaryColor, // Replace with your color constant
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], // Replace with your color constant
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: TextFormField(
                        obscureText: confirmIsVisible,
                        controller: confirmPasswordTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          if (passwordTextController.text != confirmPasswordTextController.text) {
                            return "Password not matched";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Re-enter Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmIsVisible = !confirmIsVisible;
                              });
                            },
                            icon: confirmIsVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                            color: confirmIsVisible ? Colors.grey : kPrimaryColor, // Replace with your color constant
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      minWidth: double.infinity,
                      height: 50,
                      color: kPrimaryColor, // Replace with your color constant
                      onPressed: _signUp,
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            color: Colors.white, // Replace with your color constant
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a member?",
                          style: TextStyle(color: Colors.grey), // Replace with your color constant
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Join now",
                            style: TextStyle(
                                color: kPrimaryColor, // Replace with your color constant
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
