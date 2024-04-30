// ignore_for_file: must_be_immutable

import 'dart:ffi';

import 'package:chatbot/utils/conts_utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? text;
  void Function() onpressed;
  CustomButton({super.key, required this.onpressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 61, 132, 255),
          borderRadius: BorderRadius.circular(30)),
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          text!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Textfield extends StatelessWidget {
  String? text;
  TextEditingController? controller;
  Textfield({super.key, this.controller, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 244, 245, 243)),
      child: TextField(
        style: TextStyle(color: Color.fromARGB(255, 11, 1, 29)),
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)),
      ),
    );
  }
}

class MessageField extends StatelessWidget {
  String? text;
  TextEditingController? controller;
  MessageField(
      {super.key, this.controller, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: white),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)),
            ),
          ),
        ],
      ),
    );
  }
}
