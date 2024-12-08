// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

void SnackBarMessage(BuildContext context, bool success, String meassage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: success ? Colors.green.shade300 : Colors.red,
      content: Text(
        '${meassage}',
        style: TextStyle(
            color: success ? Colors.black : Colors.white, fontSize: 15),
      ),
    ),
  );
}
