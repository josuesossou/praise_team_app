import 'package:flutter/material.dart';

void showSuccess(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueAccent,
        content: Text(
          message,
          style: TextStyle(fontSize: 15)),
      ),
    );
}

void showError(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: TextStyle(fontSize: 15),
      ),
    ),
  );
}