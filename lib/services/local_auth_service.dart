import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  Future<bool> isBiometricAvailable() async {
    LocalAuthentication auth = LocalAuthentication();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  auth({
    String? msg,
    Function()? onSuccess,
    Function()? onFail,
    AuthenticationOptions options = const AuthenticationOptions(),
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
