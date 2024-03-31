// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:chibichat/pages/home.dart';
import 'package:chibichat/pages/settings.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Home(),
      '/settings': (context) => Settings(),
    },
  ));
}
