import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/widgets/custom_textfield.dart';
import 'package:volink/widgets/round_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset("images/Volink_logo2.png"),
                height: 100,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 12,
              ),
              CustomTextField(
                prefixIcon: Icon(Icons.person),
                hintText: "Username",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_rounded),
                hintText: "E-mail",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                hintText: "Password",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                hintText: "Repeat password",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 12,
              ),
              RoundButton(
                  title: "Register",
                  color: kButtonBackgroundColor,
                  onPressed: () {
                    //TODO - 1 - Firebase register çağırılacak
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
