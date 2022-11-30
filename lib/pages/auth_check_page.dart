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
  bool hasBiometric = false;
  LocalAuthService localAuthService = LocalAuthService();

  auth() {
    localAuthService.biometricAuth(
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

  Future checkIfHasBiometric() async {
    hasBiometric = await localAuthService.isBiometricAvailable();
    setState(() {});
  }

  @override
  void initState() {
    checkIfHasBiometric();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: !hasBiometric
            ? const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Autenticação biométrica não suportada ou não ativada neste dispositivo",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                margin: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: auth,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fingerprint,
                              color: Theme.of(context).primaryColor,
                              size: 60,
                            ),
                            const SizedBox(height: 5),
                            Text("Touch id".toUpperCase()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
