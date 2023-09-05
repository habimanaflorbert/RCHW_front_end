import 'dart:ui';

import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final String? value;
  final bool isPassword;
  final bool autoCorrect;
  final TextInputType? type; 

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.value,
    this.isPassword = false,
    this.autoCorrect=true,
    this.type
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      obscureText: isPassword,
      autocorrect: autoCorrect,
      enableSuggestions:autoCorrect ,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}

class CustomTextFieldLong extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  

  const CustomTextFieldLong({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
     
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLength,
    );
  }
}


class CustomTextFieldValidation extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final String? value;
  final bool isPassword;
  final bool autoCorrect;


  const CustomTextFieldValidation({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.value,
    this.isPassword = false,
    this.autoCorrect=true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value!.length == 16) {
          return null;
        }
        return 'You entered wrong Identification number';
      },
    );
  }
}