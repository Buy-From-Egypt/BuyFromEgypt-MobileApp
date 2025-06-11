import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails)? onError;
  final VoidCallback? onErrorOccurred;
  final bool showRetryButton;
  final String? retryButtonText;
  final String? errorTitle;
  final String? errorSubtitle;
  final Color? errorColor;
  final double? errorIconSize;

  const ErrorBoundary({
    Key? key,
    required this.child,
    this.onError,
    this.onErrorOccurred,
    this.showRetryButton = true,
    this.retryButtonText,
    this.errorTitle,
    this.errorSubtitle,
    this.errorColor,
    this.errorIconSize,
  }) : super(key: key);

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  static final _logger = Logger();
  FlutterErrorDetails? _error;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      setState(() {
        _error = details;
        _retryCount++;
      });
      _logger.e('Error caught by boundary: ${details.exception}', 
        error: details.exception, 
        stackTrace: details.stack
      );
      widget.onErrorOccurred?.call();
    };
  }

  void _handleRetry() {
    if (_retryCount >= _maxRetries) {
      _logger.w('Max retry attempts reached');
      return;
    }
    setState(() {
      _error = null;
    });
    _logger.i('Retrying after error, attempt $_retryCount of $_maxRetries');
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.onError != null) {
        return widget.onError!(_error!);
      }
      return ErrorScreen(
        message: _error!.exception.toString(),
        onRetry: widget.showRetryButton && _retryCount < _maxRetries ? _handleRetry : null,
        retryButtonText: widget.retryButtonText,
        errorTitle: widget.errorTitle,
        errorSubtitle: widget.errorSubtitle,
        errorColor: widget.errorColor,
        errorIconSize: widget.errorIconSize,
      );
    }

    return widget.child;
  }
}

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final String? errorTitle;
  final String? errorSubtitle;
  final Color? errorColor;
  final double? errorIconSize;

  const ErrorScreen({
    Key? key,
    required this.message,
    this.onRetry,
    this.retryButtonText,
    this.errorTitle,
    this.errorSubtitle,
    this.errorColor,
    this.errorIconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = errorColor ?? theme.colorScheme.error;
    final iconSize = errorIconSize ?? 60.0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: color,
                  size: iconSize,
                ),
                const SizedBox(height: 16),
                Text(
                  errorTitle ?? 'Error',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (errorSubtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    errorSubtitle!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(retryButtonText ?? 'Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
} 