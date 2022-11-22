import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ottopolis/config_reader.dart';
import 'package:ottopolis/environment.dart';
import 'package:ottopolis/main.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();

  MaterialColor primaryColor;
  switch (env) {
    case Environment.dev:
      primaryColor = Colors.blue;
      break;
    case Environment.prod:
      primaryColor = Colors.purple;
      break;
    default: 
      primaryColor = Colors.red;
  }

  runApp(Provider.value(
    value: primaryColor,
    child: const MyApp(),
  ));
}
