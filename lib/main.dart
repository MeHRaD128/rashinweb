import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rashinweb/app.dart';
import 'package:rashinweb/core/storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const RashinWebApp());
}
