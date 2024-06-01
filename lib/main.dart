import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forestvpn_test/feature/initialization/initializer.dart';
import 'package:forestvpn_test/feature/initialization/model/dependencies.dart';
import 'package:forestvpn_test/feature/initialization/widget/dependencies_scope.dart';
import 'package:forestvpn_test/feature/news/widget/featured_news_scope.dart';
import 'package:forestvpn_test/feature/news/widget/news_screen.dart';

void main() {
  runZonedGuarded(() => Initializer().run(), (e, stackTrace) {});
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({required this.dependencies, Key? key})
      : super(key: key);

  final Dependencies dependencies;

  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: FeaturedNewsScope(
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF9F9F9),
            colorScheme: const ColorScheme.light(),
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFF9F9F9),
                surfaceTintColor: Color(0xFFF9F9F9),
                titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (BuildContext context) =>
                  const Icon(Icons.arrow_back_ios),
            ),
          ),
          title: 'ForestVPN test',
          home: const NewsScreen(),
          builder: (context, child) => SizedBox(
            key: _globalKey,
            child: child!,
          ),
        ),
      ),
    );
  }
}
