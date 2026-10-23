import 'package:flutter/material.dart';
import '../services/demo_auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _hidePassword = true;
  bool _hideConfirm = true;
  final _auth = const DemoAuthService();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _signup() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_auth.canCreateAccount(
      name: _name.text,
      email: _email.text,
      password: _password.text,
    )) {
      return;
    }
    _auth.createAccount(
      name: _name.text,
      email: _email.text,
      password: _password.text,
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create account')),
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
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (v) => (v?.trim().isEmpty ?? true)
                      ? 'Full name is required'
                      : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _password,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                      icon: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if ((v ?? '').isEmpty) {
                      return 'Password is required';
                    }
                    if (v!.length < 8) {
                      return 'Use at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _confirm,
                  obscureText: _hideConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _hideConfirm = !_hideConfirm),
                      icon: Icon(
                        _hideConfirm ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (v) {
                    if ((v ?? '').isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (v != _password.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 22),
                FilledButton(onPressed: _signup, child: const Text('Sign Up')),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
