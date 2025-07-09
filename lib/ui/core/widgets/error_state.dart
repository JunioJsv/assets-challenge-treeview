import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  ErrorState({
    super.key,
    String? message,
    this.onRetry,
    this.icon = Icons.error_outline,
  }) : message = message ?? translations.unknownError;

  @override
  Widget build(BuildContext context) {
    final translations = context.translations;
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(translations.tryAgain),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
