import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volink/constants.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:volink/firebase_services/auth_service.dart';
import 'package:volink/screens/main_screen.dart';
import 'package:volink/screens/registration_screen.dart';
import 'package:volink/widgets/round_button.dart';
import 'package:volink/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

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
                height: 6,
              ),
              CustomTextField(
                onChanged: (value) {
                  password = value;
                },
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                hintText: "Password",
                enabledBorderColor: Color(0xFF1D1D1F),
                focusedBorderColor: Colors.grey,
                inputTextStyle: TextStyle(color: Colors.grey),
                hideText: true,
              ),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: "Login",
                  color: kButtonBackgroundColor,
                  onPressed: () async {
                    //TODO - 1 - Login fonksiyonu çağırılacak
                    final bool checkSignIn =
                        await AuthService().signIN(email, password);

                    if (checkSignIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: EdgeInsets.all(2),
                          backgroundColor: Color(0xFF893434),
                          content: Text(
                            "Wrong username/password!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return RegistrationScreen();
                          }),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
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
