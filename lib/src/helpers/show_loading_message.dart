
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context){
  if(Platform.isAndroid){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (_) => AlertDialog(
        title: const Text('Espere por favor.'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Calculando ruta...'),
            SizedBox(height: 5),
            CircularProgressIndicator(strokeWidth: 3, color: Colors.black,)
          ],
        ),
      ),
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => const CupertinoAlertDialog(
      title: Text('Espere por favor.'),
      content: CupertinoActivityIndicator(),
    ),
  );
}