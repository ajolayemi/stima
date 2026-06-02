class EnvUtils {
  const EnvUtils._();

  static bool get useFirebaseEmulator {
    const env = String.fromEnvironment(
      'USE_FIREBASE_EMULATOR',
      defaultValue: 'false',
    );
    return env.toLowerCase() == 'true';
  }
}
