import 'package:elki_app/modules/core/presentation/scopes/repositories_scope.dart';
import 'package:elki_app/modules/rent/domain/entity/house_filter_entity.dart';
import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';
import 'package:elki_app/modules/rent/domain/entity/house_type.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/bloc/available_houses_data_bloc.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/bloc/available_houses_filter_bloc.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/bloc/available_houses_loading_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableHousesScreenScope extends StatelessWidget {
  final Widget child;

  const AvailableHousesScreenScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AvailableHousesLoadingBloc(
            rentRepository: RepositoriesScope.of(context).rentRepository,
          )..add(const AvailableHousesLoadingEvent.load()),
        ),
        BlocProvider(create: (_) => AvailableHousesFilterBloc()),
        BlocProvider(create: (_) => AvailableHousesDataBloc()),
      ],
      child: BlocListener<AvailableHousesLoadingBloc, AvailableHousesLoadingState>(
        listener: (context, state) => state.mapOrNull(
          // когда loading bloc успешно выполоняет загрузку списка домов,
          // обновляем текущий список домов в data bloc'е и применяем к спику текущий фильтр
          completed: (state) => AvailableHousesScreenScope.setData(context, state.data),
          failed: (state) => AvailableHousesScreenScope.setError(context),
        ),
        child: BlocListener<AvailableHousesFilterBloc, AvailableHousesFilterState>(
          listenWhen: (prev, curr) => prev.filter != curr.filter,
          // применяем изменённый фильтр к текущему списку домов
          listener: (context, state) => AvailableHousesScreenScope.applyFilter(context, state.filter),
          child: child,
        ),
      ),
    );
  }

  static AvailableHousesFilterBloc filterBlocOf(BuildContext context) => context.read<AvailableHousesFilterBloc>();

  static void setHouseTypeFilter(BuildContext context, HouseType type) =>
      filterBlocOf(context).add(AvailableHousesFilterEvent.setType(type));

  static void resetHouseType(BuildContext context) =>
      filterBlocOf(context).add(const AvailableHousesFilterEvent.resetType());

  static AvailableHousesDataBloc dataBlocOf(BuildContext context) => context.read<AvailableHousesDataBloc>();

  static void setData(BuildContext context, List<HouseInfoEntity> data) =>
      dataBlocOf(context).add(AvailableHousesDataEvent.setData(data));

  static void applyFilter(BuildContext context, HouseFilterEntity filter) =>
      dataBlocOf(context).add(AvailableHousesDataEvent.applyFilter(filter));

  static void setError(BuildContext context) =>
      dataBlocOf(context).add(const AvailableHousesDataEvent.setError('other'));
}
