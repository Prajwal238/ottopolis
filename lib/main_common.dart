import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ottopolis/config_reader.dart';
import 'package:ottopolis/environment.dart';
import 'package:ottopolis/main.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();

  MaterialColor primaryColor;
  bool flagPresence;
  switch (env) {
    case Environment.dev:
      primaryColor = Colors.yellow;
      flagPresence = true;
      break;
    case Environment.prod:
      primaryColor = Colors.amber;
      flagPresence = false;
      break;
    default:
      primaryColor = Colors.red;
      flagPresence = true;
  }

  runApp(MultiProvider(
    providers: [
      Provider<bool>.value(
        value: flagPresence,
      ),
      Provider<MaterialColor?>.value(
        value: primaryColor,
      ),
    ],
    child: const MyApp(),
  ));
}
