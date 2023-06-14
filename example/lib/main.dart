import 'package:flutter/material.dart';

import 'app.dart';
import 'app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  runApp(const MyApp());
}
