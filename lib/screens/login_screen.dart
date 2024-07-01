import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:foody_app2/screens/signup_screen.dart';
import 'package:foody_app2/screens/user_home.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../consts.dart';

import '../models/models.dart';
import '../services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Log in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20,),
                const TextFields(),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member ?",
                      style: TextStyle(color: kTextGrayColor),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        "Join us",
                        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFields extends StatefulWidget {
  const TextFields({super.key});

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isVisible = true;
  final ApiService apiService = ApiService();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final request = LoginRequest(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      try {
        final response = await apiService.loginUser(request);
        String token = response.token;
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
        print(decodedToken);
        userId = decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
        if (response.flag) {
          print('Login successful: ${response.message}');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserHome()));
        } else {
          print('Login failed: ${response.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${response.message}')),
          );
        }
      } catch (error) {
        print('Login failed: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // email field
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                color: kGrayColor, borderRadius: BorderRadius.circular(50)),
            child: TextFormField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Email";
                }
                final bool isvalid = EmailValidator.validate(emailTextController.text);
                if (!isvalid) {
                  return "Email was entered incorrectly";
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: "Email",
                  suffixIcon: Icon(Icons.email_outlined),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          const SizedBox(height: 20),
          // password field
          Container(
            padding: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                color: kGrayColor, borderRadius: BorderRadius.circular(50)),
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
                    icon: isVisible == true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    color: isVisible == true ? kTextGrayColor : kPrimaryColor,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          const SizedBox(height: 50),
          // login button
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            minWidth: double.infinity,
            height: 50,
            color: kPrimaryColor,
            onPressed: _login,
            child: const Text(
              "Login",
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
