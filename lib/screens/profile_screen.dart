import 'package:flutter/material.dart';

import '../consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 1,),
            const CircleAvatar(

              radius: 50,
              backgroundImage: AssetImage('assets/images/personal_image.jpg'),
            ),
            const SizedBox(height: 20),


            const SizedBox(height: 30),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: kPrimaryColor),
                title: const Text('Name'),
                subtitle: Text(userData.name),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(Icons.email, color: kPrimaryColor),
                title: const Text('Email'),
                subtitle: Text("example@gmail.com"),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.phone, color: kPrimaryColor),
                title: Text('Phone'),
                subtitle: Text(userData.phoneNumber),
              ),
            ),
            const Spacer(flex: 1,)
          ],
        ),
      ),
    );
  }
}