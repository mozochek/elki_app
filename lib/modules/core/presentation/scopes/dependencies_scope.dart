import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
class DependenciesStore {
  final Dio dio;

  const DependenciesStore({
    required this.dio,
  });

  void dispose() {
    dio.close();
  }
}

class DependenciesScope extends StatefulWidget {
  final Widget child;

  const DependenciesScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<DependenciesScope> createState() => _DependenciesScopeState();

  static DependenciesStore of(BuildContext context) {
    final inhWidget = context.findAncestorWidgetOfExactType<_DependenciesInhScope>();

    if (inhWidget is! _DependenciesInhScope) {
      throw Exception('_DependenciesInhScope was not found above \'${context.widget}\' widget.');
    }

    return inhWidget.store;
  }
}

class _DependenciesScopeState extends State<DependenciesScope> {
  late final DependenciesStore _store;

  @override
  void initState() {
    super.initState();

    _store = DependenciesStore(
      dio: Dio()
        ..options = BaseOptions(
          baseUrl: 'https://elki.rent/',
          connectTimeout: 7000,
          sendTimeout: 7000,
          receiveTimeout: 7000,
        ),
    );
  }

  @override
  void dispose() {
    _store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DependenciesInhScope(
      store: _store,
      child: widget.child,
    );
  }
}

class _DependenciesInhScope extends InheritedWidget {
  final DependenciesStore store;

  const _DependenciesInhScope({
    required this.store,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is _DependenciesInhScope && store != oldWidget.store;
}
