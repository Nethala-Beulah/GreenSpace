/// Session-only demo account. This is not real or secure authentication.
class DemoAuthService {
  const DemoAuthService();

  static _DemoAccount? _account;

  void createAccount({
    required String name,
    required String email,
    required String password,
  }) {
    _account = _DemoAccount(
      name: name.trim(),
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  bool authenticate({required String email, required String password}) {
    final account = _account;
    return account != null &&
        account.email == email.trim().toLowerCase() &&
        account.password == password;
  }

  static void resetForTesting() => _account = null;

  bool canCreateAccount({
    required String name,
    required String email,
    required String password,
  }) =>
      name.trim().isNotEmpty && email.trim().isNotEmpty && password.isNotEmpty;
}

class _DemoAccount {
  final String name;
  final String email;
  final String password;

  const _DemoAccount({
    required this.name,
    required this.email,
    required this.password,
  });
}
