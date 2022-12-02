import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const CustomTextField({Key? key,
    required this.title,
    required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: title == 'password',
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
