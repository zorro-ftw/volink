import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:volink/widgets/round_button.dart';
import 'package:volink/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("images/Volink_logo2.png"),
                height: 120,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 5,
              ),
              GradientText(
                "VOLink",
                gradient: LinearGradient(
                    colors: [kTextGradientColor1, kTextGradientColor2]),
                style: TextStyle(fontSize: 36),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                prefixIcon: Icon(Icons.email_rounded),
                hintText: "E-mail",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 6,
              ),
              CustomTextField(
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                hintText: "Password",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: "Login",
                  color: Color(0xFF384152),
                  onPressed: () {
                    //TODO - 1 - Login fonksiyonu çağırılacak
                  }),
              SizedBox(
                height: 5,
              ),
              kDivider,
              SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade500),
                    ),
                    GestureDetector(
                      onTap: () {
                        //TODO - 2 - Sign Up sayfasına navigate edilecek
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2),
                      ),
                    ),
                    Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
