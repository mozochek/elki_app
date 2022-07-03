import 'package:elki_app/modules/rent/modules/available_houses/domain/entity/house_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_houses_loading_bloc.freezed.dart';

class AvailableHousesLoadingBloc extends Bloc<AvailableHousesLoadingEvent, AvailableHousesLoadingState> {
  AvailableHousesLoadingBloc() : super(const AvailableHousesLoadingState.notInitialized()) {
    on<AvailableHousesLoadingEvent>((event, emit) {

    });
  }
}

@freezed
class AvailableHousesLoadingEvent with _$AvailableHousesLoadingEvent {
  const AvailableHousesLoadingEvent._();

  const factory AvailableHousesLoadingEvent.load(HouseFilter filter) = _AvailableHousesLoadingEventLoad;
}

@freezed
class AvailableHousesLoadingState with _$AvailableHousesLoadingState {
  const AvailableHousesLoadingState._();

  const factory AvailableHousesLoadingState.notInitialized() = _AvailableHousesLoadingStateNotInitialized;
}
