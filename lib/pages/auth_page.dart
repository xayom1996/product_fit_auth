import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product_fit_auth/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  String pageStatus = 'Signup';
  String errorMessage = '';
  bool isAuth = false;

  void login() async {
    errorMessage = '';
    Map<String, String> body = {
      "email": email.text,
      "password": password.text,
    };
    var url = Uri.parse('https://dasta.vilion-k.ru/api/v1/deliverymen/login');
    var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body)
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'ok') {
      isAuth = true;
      clearDatas();
    } else {
      errorMessage = responseBody['error'];
    }
    setState(() {});
  }

  void signup() async {
    errorMessage = '';
    Map<String, String> body = {
      "username": userName.text,
      "firstName": firstName.text,
      "middleName": middleName.text,
      "lastName": lastName.text,
      "password": password.text,
      "email": email.text,
      "phone": phone.text,
    };
    var url = Uri.parse('https://dasta.vilion-k.ru/api/v1/deliverymen/signup');
    var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body)
    );
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'ok') {
      isAuth = true;
      clearDatas();
    } else {
      errorMessage = responseBody['error'];
    }
    setState(() {});
  }

  void changeStatus () {
    pageStatus = pageStatus == 'Signup'
        ? 'Login'
        : 'Signup';
    clearDatas();
    setState(() {});
  }

  void clearDatas() {
    userName.clear();
    firstName.clear();
    middleName.clear();
    lastName.clear();
    lastName.clear();
    phone.clear();
    email.clear();
    password.clear();
    errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAuth
          ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAuth = false;
                    });
                  },
                  child: Text(
                    'LogOut'
                  ),
                ),
              ],
            ),
          )
          : Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  if (pageStatus == 'Signup') ... [
                    CustomTextField(controller: userName, title: 'userName'),
                    CustomTextField(controller: firstName, title: 'firstName'),
                    CustomTextField(controller: middleName, title: 'middleName'),
                    CustomTextField(controller: lastName, title: 'lastName'),
                    CustomTextField(controller: phone, title: 'phone'),
                  ],
                  CustomTextField(controller: email, title: 'email'),
                  CustomTextField(controller: password, title: 'password'),
                  if (errorMessage != '')
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ElevatedButton(
                      onPressed: pageStatus == 'Signup'
                          ? signup
                          : login,
                      child: Text(pageStatus),
                  ),
                  TextButton(
                    onPressed: changeStatus,
                    child: Text(
                      pageStatus == 'Signup'
                        ? 'Login'
                        : 'Signup',
                    ),
                  ),
                ],
              ),
            )
    );
  }
}
