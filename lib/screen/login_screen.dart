import 'package:ahulang/ahulang_theme.dart';
import 'package:ahulang/api/auth_service.dart';
import 'package:ahulang/home.dart';
import 'package:ahulang/model/route_manager.dart';
import 'package:ahulang/model/tab_manager.dart';
import 'package:ahulang/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final registerLabel =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      FlatButton(
          padding: EdgeInsets.all(0.0),
          onPressed: () {},
          child: Text(
            "Don't have account?",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )),
      FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          onPressed: () {
            Navigator.pushNamed(context, RouteManager.RegisterPage);
          },
          child: Text(
            "Sign Up",
            style:
                TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
          ))
    ]);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Write your email',
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)))),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Write your password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 5,
                  child: Container(
                    height: 50,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () async {
                        if (await AuthService.signIn(emailController.text,
                                passwordController.text) !=
                            null) {
                          Navigator.pushNamed(context, RouteManager.HomePage);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Your email or password incorrect")));
                        }
                      },
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
              registerLabel
            ],
          ),
        ),
      ),
    );
  }
}
