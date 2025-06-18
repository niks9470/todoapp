import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.content,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onLeftPressed,
    required this.onRightPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onLeftPressed,
                    child: Text(leftButtonText),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onRightPressed,
                    child: Text(rightButtonText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
