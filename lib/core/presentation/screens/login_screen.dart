import 'package:flutter/material.dart';
// import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        // child: CustomButton(
        //   text: "Go to Home",
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/home');
        //   },
        // ),
      ),
    );
  }
}