import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_biometric_auth/pages/home_page.dart';
import 'package:flutter_biometric_auth/services/local_auth_service.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  LocalAuthService localAuthService = LocalAuthService();

  auth() {
    localAuthService.auth(
      onSuccess: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      onFail: () {
        log("Erro ao autenticar");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    auth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: auth,
          child: const Text("Auth"),
        ),
      ),
    );
  }
}
