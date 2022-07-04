import 'package:elki_app/modules/rent/domain/entity/house_filter_entity.dart';
import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_houses_data_bloc.freezed.dart';

class AvailableHousesDataBloc extends Bloc<AvailableHousesDataEvent, AvailableHousesDataState> {
  AvailableHousesDataBloc() : super(const AvailableHousesDataState.notInitialized()) {
    on<AvailableHousesDataEvent>(
      (event, emit) {
        event.map(
          setData: (event) {
            final lastFilter = state.mapOrNull(
              data: (state) => state.lastAppliedFilter,
            );

            var dataToDisplay = event.data;
            if (lastFilter != null) {
              dataToDisplay = _applyFilter(event.data, lastFilter);
            }

            emit(AvailableHousesDataState.data(
              data: event.data,
              dataToDisplay: dataToDisplay,
              lastAppliedFilter: lastFilter,
            ));
          },
          applyFilter: (event) {
            state.mapOrNull(
              data: (state) {
                final dataToDisplay = _applyFilter(state.data, event.filter);

                emit(AvailableHousesDataState.data(
                  data: state.data,
                  dataToDisplay: dataToDisplay,
                  lastAppliedFilter: event.filter,
                ));
              },
            );
          },
        );
      },
    );
  }

  List<HouseInfoEntity> _applyFilter(List<HouseInfoEntity> data, HouseFilterEntity filter) {
    if (filter.type == null) return data;

    return data.where((entity) => entity.type == filter.type).toList();
  }
}

@freezed
class AvailableHousesDataEvent with _$AvailableHousesDataEvent {
  const AvailableHousesDataEvent._();

  const factory AvailableHousesDataEvent.setData(List<HouseInfoEntity> data) = _AvailableHousesDataEventSetData;

  const factory AvailableHousesDataEvent.applyFilter(HouseFilterEntity filter) = _AvailableHousesDataEventApplyFilter;
}

@freezed
class AvailableHousesDataState with _$AvailableHousesDataState {
  const AvailableHousesDataState._();

  const factory AvailableHousesDataState.notInitialized() = _AvailableHousesDataStateNotInitialized;

  const factory AvailableHousesDataState.data({
    required List<HouseInfoEntity> data,
    required List<HouseInfoEntity> dataToDisplay,
    HouseFilterEntity? lastAppliedFilter,
  }) = _AvailableHousesDataStateData;
}
