import 'package:local_auth/local_auth.dart';

class BiometricUtils {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> checkBiometricSupport() async {
    return await auth.canCheckBiometrics && await auth.isDeviceSupported();
  }
}
