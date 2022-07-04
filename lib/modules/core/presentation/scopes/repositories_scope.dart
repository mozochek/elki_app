import 'package:elki_app/modules/core/presentation/scopes/dependencies_scope.dart';
import 'package:elki_app/modules/rent/data/test_rent_repository.dart';
import 'package:elki_app/modules/rent/domain/repository/i_rent_repository.dart';
import 'package:flutter/material.dart';

@immutable
class RepositoriesStore {
  final IRentRepository rentRepository;

  const RepositoriesStore({
    required this.rentRepository,
  });
}

class RepositoriesScope extends StatefulWidget {
  final Widget child;

  const RepositoriesScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<RepositoriesScope> createState() => _RepositoriesScopeState();

  static RepositoriesStore of(BuildContext context) {
    final inhWidget = context.findAncestorWidgetOfExactType<_RepositoriesInhScope>();

    if (inhWidget is! _RepositoriesInhScope) {
      throw Exception('_RepositoriesInhScope was not found above \'${context.widget}\' widget.');
    }

    return inhWidget.store;
  }
}

class _RepositoriesScopeState extends State<RepositoriesScope> {
  late final RepositoriesStore _store;

  @override
  void initState() {
    super.initState();

    final dependencies = DependenciesScope.of(context);
    _store = RepositoriesStore(
      rentRepository: TestRentRepository(dio: dependencies.dio),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RepositoriesInhScope(
      store: _store,
      child: widget.child,
    );
  }
}

class _RepositoriesInhScope extends InheritedWidget {
  final RepositoriesStore store;

  const _RepositoriesInhScope({
    required this.store,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget is _RepositoriesInhScope && store != oldWidget.store;
}
