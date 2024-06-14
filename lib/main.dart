// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somaa/providers/auth_provider.dart';
import 'package:somaa/providers/subject_provider.dart';
import 'package:somaa/providers/user_provider.dart';
import 'package:somaa/screens/authenticate/log_in.dart';
import 'package:somaa/screens/authenticate/sign_in.dart';
import 'package:somaa/screens/home/home.dart';
import 'package:somaa/screens/home/profile/userprofile.dart';
// import 'package:system_auth/providers/auth_provider.dart';
// import 'package:system_auth/providers/user_provider.dart';
// import 'package:system_auth/providers/subject_provider.dart';
// import 'package:system_auth/screens/authenticate/log_in.dart';
// import 'package:system_auth/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogIn(),
      ),
    );
  }
}
