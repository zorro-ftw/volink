import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/screens/login_screen.dart';
import 'package:volink/widgets/custom_textfield.dart';
import 'package:volink/widgets/round_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String userName, password, passwordRep, email;

  startRegister(BuildContext context) async {
    final String nameValidate = NameValidator.validate(userName);
    final String emailValidate = EmailValidator.validate(email);
    final String passwordValidate =
        PasswordValidator.validate(password, passwordRep);
    if (nameValidate != null ||
        emailValidate != null ||
        passwordValidate != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.all(2),
          backgroundColor: Color(0xFF893434),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                nameValidate == null
                    ? Container()
                    : Text(
                        nameValidate,
                        textAlign: TextAlign.center,
                      ),
                emailValidate == null
                    ? Container()
                    : Text(
                        emailValidate,
                        textAlign: TextAlign.center,
                      ),
                passwordValidate == null
                    ? Container()
                    : Text(
                        passwordValidate,
                        textAlign: TextAlign.center,
                      )
              ],
            ),
          ),
        ),
      );
    } else {
      await AuthService()
          .registerUser(email: email, password: password, userName: userName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.all(2),
          backgroundColor: Color(0xFF3C7940),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Registered succesfully!")],
            ),
          ),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    }
  }

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
                onChanged: (value) {
                  userName = value;
                },
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
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                hideText: true,
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                hintText: "Password",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                hideText: true,
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                hintText: "Repeat password",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
                onChanged: (value) {
                  passwordRep = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              RoundButton(
                title: "Register",
                color: kButtonBackgroundColor,
                onPressed: () async {
                  await startRegister(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
