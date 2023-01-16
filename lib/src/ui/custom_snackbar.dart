
import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key, 
    String label = 'OK',
    VoidCallback? onPressed,
    required String message
  }) : super(
    key: key,
    content: Text(message),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: label, 
      onPressed: () {
        if(onPressed== null)return;
        onPressed();
      },
    )
  );
}