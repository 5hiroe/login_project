import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.blueGrey, width: 1),
  ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.blue, width: 1),
  )
);