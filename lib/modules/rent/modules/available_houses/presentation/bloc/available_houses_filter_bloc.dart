import 'package:elki_app/modules/rent/domain/entity/house_filter_entity.dart';
import 'package:elki_app/modules/rent/domain/entity/house_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_houses_filter_bloc.freezed.dart';

class AvailableHousesFilterBloc extends Bloc<AvailableHousesFilterEvent, AvailableHousesFilterState> {
  AvailableHousesFilterBloc() : super(const AvailableHousesFilterState(HouseFilterEntity())) {
    on<AvailableHousesFilterEvent>((event, emit) {
      event.map(
        setType: (event) {
          emit(state.copyWith(
            filter: state.filter.copyWith(type: event.type),
          ));
        },
        resetType: (event) {
          emit(state.copyWith(
            filter: state.filter.copyWith(type: null),
          ));
        },
      );
    });
  }
}

@freezed
class AvailableHousesFilterEvent with _$AvailableHousesFilterEvent {
  const AvailableHousesFilterEvent._();

  const factory AvailableHousesFilterEvent.setType(HouseType type) = _AvailableHousesFilterEventSetType;

  const factory AvailableHousesFilterEvent.resetType() = _AvailableHousesFilterEventResetType;
}

@freezed
class AvailableHousesFilterState with _$AvailableHousesFilterState {
  const AvailableHousesFilterState._();

  const factory AvailableHousesFilterState(
    HouseFilterEntity filter,
  ) = _AvailableHousesFilterState;
}
