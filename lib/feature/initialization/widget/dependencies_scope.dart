import 'package:flutter/material.dart';
import 'package:forestvpn_test/core/extensions/context_extensions.dart';
import 'package:forestvpn_test/feature/initialization/model/dependencies.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final Dependencies dependencies;

  static Dependencies of(BuildContext context) =>
      context.inhOf<DependenciesScope>(listen: false).dependencies;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
