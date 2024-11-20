import 'package:local_auth/local_auth.dart';
import 'package:remember_my_love_app/utills/CustomSnackbar.dart';

class LocalAuthService {
  static final LocalAuthentication _localAuth =
      LocalAuthentication(); // LocalAuthentication instance (static)

  // Static method to check if biometric authentication can be used on the device
  static Future<bool> canAuthenticate() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      CustomSnackbar.showError(
          "Authentication Error", "Could not check for biometrics.");
      return false;
    }
  }

  // Static method to check if any biometrics (Fingerprint, Face ID, etc.) are available and enrolled
  static Future<bool> hasBiometrics() async {
    try {
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      CustomSnackbar.showError(
          "Authentication Error", "Could not retrieve biometrics.");
      return false;
    }
  }

  // Static method to authenticate the user using biometrics (Fingerprint, Face ID, etc.)
  static Future<bool> authenticateUser() async {
    // Check if biometric authentication can be used and if there are any enrolled biometrics
    bool canAuthenticateBiometrics = await canAuthenticate();
    bool hasBiometricsFeature = await hasBiometrics();

    if (!canAuthenticateBiometrics || !hasBiometricsFeature) {
      CustomSnackbar.showError("Biometric Authentication",
          "Biometric authentication is not available or enrolled.");
      return false; // If either check fails, return false
    }

    // Proceed with authentication if biometrics are available
    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(stickyAuth: true),
      );
      return isAuthenticated;
    } catch (e) {
      CustomSnackbar.showError("Authentication Failed",
          "An error occurred during biometric authentication.");
      return false;
    }
  }
}
