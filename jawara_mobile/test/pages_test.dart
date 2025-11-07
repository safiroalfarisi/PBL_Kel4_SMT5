import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jawara_mobile/pages/login_page.dart';
import 'package:jawara_mobile/pages/register_page.dart';
import 'package:jawara_mobile/pages/dashboard_page.dart';

void main() {
  testWidgets('Login page builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Register page builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
    // The register page uses Indonesian labels
    expect(find.text('Daftar Akun'), findsOneWidget);
    expect(find.text('Buat Akun'), findsOneWidget);
  });

  testWidgets('Dashboard page builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
