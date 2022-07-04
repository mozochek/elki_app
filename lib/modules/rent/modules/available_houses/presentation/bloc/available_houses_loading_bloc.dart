import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';
import 'package:elki_app/modules/rent/domain/repository/i_rent_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_houses_loading_bloc.freezed.dart';

class AvailableHousesLoadingBloc extends Bloc<AvailableHousesLoadingEvent, AvailableHousesLoadingState> {
  final IRentRepository _rentRepository;

  AvailableHousesLoadingBloc({
    required IRentRepository rentRepository,
  })  : _rentRepository = rentRepository,
        super(const AvailableHousesLoadingState.notInitialized()) {
    on<AvailableHousesLoadingEvent>((event, emit) async {
      await event.when(
        load: () async {
          try {
            emit(const AvailableHousesLoadingState.inProgress());
            final loadedData = await _rentRepository.fetchAvailableHouses();
            emit(AvailableHousesLoadingState.completed(loadedData));
          } on Object {
            emit(const AvailableHousesLoadingState.failed());
            rethrow;
          }
        },
      );
    }, transformer: bloc_concurrency.droppable());
  }
}

@freezed
class AvailableHousesLoadingEvent with _$AvailableHousesLoadingEvent {
  const AvailableHousesLoadingEvent._();

  const factory AvailableHousesLoadingEvent.load() = _AvailableHousesLoadingEventLoad;
}

@freezed
class AvailableHousesLoadingState with _$AvailableHousesLoadingState {
  const AvailableHousesLoadingState._();

  const factory AvailableHousesLoadingState.notInitialized() = _AvailableHousesLoadingStateNotInitialized;

  const factory AvailableHousesLoadingState.inProgress() = _AvailableHousesLoadingStateInProgress;

  const factory AvailableHousesLoadingState.completed(
    List<HouseInfoEntity> data,
  ) = _AvailableHousesLoadingStateCompleted;

  const factory AvailableHousesLoadingState.failed() = _AvailableHousesLoadingStateFailed;
}
