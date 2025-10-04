import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

class AppUtils {
  const AppUtils._();

  static String obfuscateEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }

    final visible = username.substring(0, 2);
    final obfuscated = '*' * (username.length - 2);
    return '$visible$obfuscated@$domain';
  }

  static void resetPasswordVisibilityProviders(WidgetRef ref) {
    ref.invalidate(showPasswordProvider);
    ref.invalidate(showConfirmPasswordProvider);
  }
}