import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spring_note/core/router/app_shell.dart';
import 'package:spring_note/core/services/local_data_service.dart';
import 'package:spring_note/core/theme/app_theme.dart';

void main() {
  testWidgets('SpringNote app shows home shell', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final temp = await tester.runAsync(
      () => Directory.systemTemp.createTemp('spring_note_widget_test_'),
    );
    expect(temp, isNotNull);

    addTearDown(() async {
      final directory = temp;
      if (directory != null && await directory.exists()) {
        await directory.delete(recursive: true);
      }
    });

    final state = await tester.runAsync(
      () => LocalDataService(appDataPath: temp!.path).initialize(),
    );
    expect(state, isNotNull);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: AppShell(localDataState: state!),
      ),
    );

    expect(find.text('首页'), findsOneWidget);
    expect(find.text('今日收益'), findsOneWidget);
    expect(find.text('完成事项'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.sticky_note_2_outlined));
    await tester.pump();
    expect(find.text('Markdown 源码'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pump();
    expect(find.text('偏好设置'), findsOneWidget);
  });
}
