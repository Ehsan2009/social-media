import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog({
  required BuildContext context,
  String? content,
}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        content: SizedBox(
          width: 200,
          height: 100,
          child: Text(
            'We have an error: $content',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}