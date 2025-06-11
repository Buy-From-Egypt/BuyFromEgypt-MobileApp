import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoadingState extends ChangeNotifier {
  static final _logger = Logger();
  
  bool _isLoading = false;
  String? _loadingMessage;
  String? _errorMessage;
  double? _progress;
  bool _isRetrying = false;

  bool get isLoading => _isLoading;
  String? get loadingMessage => _loadingMessage;
  String? get errorMessage => _errorMessage;
  double? get progress => _progress;
  bool get isRetrying => _isRetrying;

  void startLoading([String? message]) {
    _isLoading = true;
    _loadingMessage = message;
    _errorMessage = null;
    _progress = null;
    _isRetrying = false;
    notifyListeners();
    _logger.i('Loading started: $message');
  }

  void stopLoading() {
    _isLoading = false;
    _loadingMessage = null;
    _progress = null;
    _isRetrying = false;
    notifyListeners();
    _logger.i('Loading stopped');
  }

  void setError(String message) {
    _errorMessage = message;
    _isLoading = false;
    _loadingMessage = null;
    _progress = null;
    _isRetrying = false;
    notifyListeners();
    _logger.e('Error set: $message');
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
    _logger.i('Error cleared');
  }

  void setProgress(double progress) {
    _progress = progress;
    notifyListeners();
    _logger.i('Progress updated: $progress');
  }

  void startRetry() {
    _isRetrying = true;
    notifyListeners();
    _logger.i('Retry started');
  }

  void stopRetry() {
    _isRetrying = false;
    notifyListeners();
    _logger.i('Retry stopped');
  }

  void reset() {
    _isLoading = false;
    _loadingMessage = null;
    _errorMessage = null;
    _progress = null;
    _isRetrying = false;
    notifyListeners();
    _logger.i('State reset');
  }
}

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final double? progress;
  final bool isRetrying;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? textColor;

  const LoadingOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
    this.message,
    this.progress,
    this.isRetrying = false,
    this.backgroundColor,
    this.progressColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (progress != null)
                    CircularProgressIndicator(
                      value: progress,
                      color: progressColor ?? Colors.white,
                    )
                  else
                    CircularProgressIndicator(
                      color: progressColor ?? Colors.white,
                    ),
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        message!,
                        style: TextStyle(
                          color: textColor ?? Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (isRetrying)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Retrying...',
                        style: TextStyle(
                          color: textColor ?? Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
} 