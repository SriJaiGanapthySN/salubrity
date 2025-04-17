import 'package:flutter/material.dart';

class VideoErrorHandler {
  final BuildContext context;

  VideoErrorHandler(this.context);

  void handleInitializationError(dynamic error) {
    debugPrint("Error initializing video: $error");
    _showErrorSnackBar("Error loading video: ${error.toString()}");
  }

  void handlePlatformException(Exception e) {
    debugPrint("Platform Exception: $e");
    _showErrorSnackBar("Failed to load video: ${e.toString()}");
  }

  void _showErrorSnackBar(String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
