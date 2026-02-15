import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hotwheels_app/features/splash/splash_screen.dart';
import 'package:hotwheels_app/widgets/error_view.dart';
import 'package:hotwheels_app/widgets/loading_overlay.dart';

void main() {
  testWidgets('SplashScreen shows app name and spinner', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SplashScreen()),
    );

    expect(find.text('Hot Wheels Collection'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ErrorView shows message and retry button', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ErrorView(
          message: 'Something went wrong',
          onRetry: () => retried = true,
        ),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });

  testWidgets('LoadingOverlay shows spinner when loading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoadingOverlay(
          isLoading: true,
          child: Text('Content'),
        ),
      ),
    );

    expect(find.text('Content'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('LoadingOverlay hides spinner when not loading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoadingOverlay(
          isLoading: false,
          child: Text('Content'),
        ),
      ),
    );

    expect(find.text('Content'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
