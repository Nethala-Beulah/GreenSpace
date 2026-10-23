import 'package:flutter/material.dart';
import '../services/demo_auth_service.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;
  String? _feedback;
  bool _feedbackIsError = false;
  final _auth = const DemoAuthService();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    if (!_auth.authenticate(email: _email.text, password: _password.text)) {
      setState(() {
        _feedback =
            'Email or password is incorrect. Create a demo account first.';
        _feedbackIsError = true;
      });
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  Future<void> _openSignup() async {
    final result = await Navigator.pushNamed<dynamic>(context, '/signup');
    if (!mounted || result != true) return;
    setState(() {
      _feedback = 'Demo account created. You can now log in.';
      _feedbackIsError = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('GreenSpace')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.eco, size: 56, color: AppTheme.primaryGreen),
                const SizedBox(height: 12),
                Text(
                  'Welcome back',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                if (_feedback != null) ...[
                  Text(
                    _feedback!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _feedbackIsError
                          ? Theme.of(context).colorScheme.error
                          : AppTheme.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(email)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: _hidePassword
                          ? 'Show password'
                          : 'Hide password',
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      icon: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) =>
                      (value ?? '').isEmpty ? 'Password is required' : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password recovery will be available when authentication is connected.',
                        ),
                      ),
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton(onPressed: _login, child: const Text('Log In')),
                TextButton(
                  onPressed: _openSignup,
                  child: const Text('Create an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
