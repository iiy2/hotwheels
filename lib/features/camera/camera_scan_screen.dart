import 'package:flutter/material.dart';

class CameraScanScreen extends StatelessWidget {
  const CameraScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Camera scanning coming soon',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
