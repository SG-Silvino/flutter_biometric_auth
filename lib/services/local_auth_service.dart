import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  Future<bool> isBiometricAvailable() async {
    LocalAuthentication auth = LocalAuthentication();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();
    final hasBiometric = canAuthenticateWithBiometrics && isDeviceSupported;

    return hasBiometric;
  }

  biometricAuth({
    String? msg,
    Function()? onSuccess,
    Function()? onFail,
    AuthenticationOptions options =
        const AuthenticationOptions(biometricOnly: true),
  }) async {
    LocalAuthentication auth = LocalAuthentication();
    final isLocalAuthAvailable = await isBiometricAvailable();

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate(
        localizedReason: msg ?? 'Por favor, autentique-se para acessar o app.',
        options: options,
      );

      !authenticated ? onFail!() : onSuccess!();
    }
  }
}
