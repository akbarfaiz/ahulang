import 'package:ahulang/api/auth_service.dart';
import 'package:ahulang/model/account.dart';
import 'package:ahulang/model/route_manager.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController nipController = TextEditingController(text: "");
  TextEditingController sectorController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: new Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sign Up",
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                    obscureText: true,
                    controller: confirmController,
                    decoration: InputDecoration(
                      hintText: 'Write your password',
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Write your name',
                        labelText: 'Name',
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
                    controller: nipController,
                    decoration: InputDecoration(
                        hintText: 'Write your nip',
                        labelText: 'NIP',
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
                    controller: sectorController,
                    decoration: InputDecoration(
                        hintText: 'Write your sector',
                        labelText: 'Sector',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)))),
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
                        if (passwordController.text == confirmController.text) {
                          if (emailController.text != "" &&
                              passwordController.text != "" &&
                              nameController.text != "" &&
                              nipController.text != "" &&
                              sectorController.text != "") {
                            AuthService.signUp(Account(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                nipController.text,
                                sectorController.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Sign Up Success")));
                            Navigator.pushNamed(
                                context, RouteManager.LoginPage);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Make sure you have fill all form, your email not register, and your password more than 6 letters")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Your password don't same")));
                        }
                      },
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
