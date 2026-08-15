import 'package:flutter/material.dart';

import '../data/auth_service.dart';

/// Sign-in for the principal.
///
/// Note the "Continue offline" escape hatch. A login wall that cannot be
/// passed when the internet is down would contradict the entire premise of the
/// system — the school's connection is out for hours at a time, and the
/// register still has to be marked at 8am (CLAUDE.md §2).
class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.auth, super.key});

  final AuthService auth;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'principal@igs.edu.pk');
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.auth.signIn(
      email: _email.text,
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final busy = widget.auth.state == AuthState.signingIn;
    final unavailable = widget.auth.state == AuthState.unavailable;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.account_balance,
                      size: 44, color: theme.colorScheme.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Islamabad Grammar School',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Administration',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.disabledColor),
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _email,
                    enabled: !busy && !unavailable,
                    autofillHints: const [AutofillHints.username],
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || !value.contains('@'))
                            ? 'Enter the principal\'s email'
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    enabled: !busy && !unavailable,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    onFieldSubmitted: (_) => busy ? null : _submit(),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Enter your password'
                        : null,
                  ),
                  if (widget.auth.error case final message?) ...[
                    const SizedBox(height: 14),
                    _Banner(
                      icon: Icons.error_outline,
                      color: theme.colorScheme.error,
                      message: message,
                    ),
                  ],
                  if (unavailable) ...[
                    const SizedBox(height: 14),
                    _Banner(
                      icon: Icons.cloud_off,
                      color: theme.colorScheme.tertiary,
                      message: 'Cannot reach the server. You can still work '
                          'offline — changes queue and sync later.',
                    ),
                  ],
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: busy || unavailable ? null : _submit,
                    child: busy
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sign in'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: busy ? null : widget.auth.continueOffline,
                    child: const Text('Continue offline'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    required this.icon,
    required this.color,
    required this.message,
  });

  final IconData icon;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
