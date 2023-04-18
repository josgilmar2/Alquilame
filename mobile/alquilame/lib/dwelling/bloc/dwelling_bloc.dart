import 'package:alquilame/dwelling/dwelling.dart';
import 'package:alquilame/services/dwelling_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);
//int page = 0;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class DwellingBloc extends Bloc<DwellingEvent, DwellingState> {
  final DwellingService _dwellingService;

  DwellingBloc(DwellingService dwellingService)
      : assert(dwellingService != null),
        _dwellingService = dwellingService,
        super(const DwellingState()) {
    on<DwellingFetched>(_onDwellingFetched);
    on<DwellingRefresh>(_onDwellingRefresh);
    on<DwellingUserFetched>(_onDwellingUserFetched);
    on<DwellingDelete>(_onDwellingDelete);
  }

  Future<void> _onDwellingFetched(
      DwellingFetched event, Emitter<DwellingState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DwellingStatus.initial) {
        final dwellings = await _dwellingService.getAllDwellings(state.page);
        return emitter(state.copyWith(
            status: DwellingStatus.success,
            dwellings: dwellings.content,
            hasReachedMax: dwellings.totalPages - 1 <= state.page,
            page: state.page + 1));
      }
      final dwellings = await _dwellingService.getAllDwellings(state.page);
      emitter(state.copyWith(
          status: DwellingStatus.success,
          dwellings: List.of(state.dwellings)..addAll(dwellings.content),
          hasReachedMax: dwellings.totalPages - 1 <= state.page,
          page: state.page + 1));
    } catch (_) {
      emitter(state.copyWith(status: DwellingStatus.failure));
    }
  }

  Future<void> _onDwellingRefresh(
      DwellingRefresh event, Emitter<DwellingState> emitter) async {
    final dwellings = await _dwellingService.getAllDwellings(state.page);
    return emitter(state.copyWith(
        status: DwellingStatus.success,
        dwellings: List.of(state.dwellings)..addAll(dwellings.content),
        hasReachedMax: dwellings.totalPages - 1 <= state.page,
        page: state.page + 1));
  }

  Future<void> _onDwellingUserFetched(
      DwellingUserFetched event, Emitter<DwellingState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DwellingStatus.initial) {
        final dwellings = await _dwellingService.getUserDwellings(state.page);
        return emitter(state.copyWith(
            status: DwellingStatus.success,
            dwellings: dwellings.content,
            hasReachedMax: dwellings.number - 1 <= state.page,
            page: state.page + 1));
      }
      final dwellings = await _dwellingService.getUserDwellings(state.page);
      emitter(state.copyWith(
          status: DwellingStatus.success,
          dwellings: List.of(state.dwellings)..addAll(dwellings.content),
          hasReachedMax: dwellings.number - 1 <= state.page,
          page: state.page + 1));
    } catch (_) {
      emitter(state.copyWith(status: DwellingStatus.failure));
    }
  }

  Future<void> _onDwellingDelete(
      DwellingDelete event, Emitter<DwellingState> emitter) async {
    try {
      await _dwellingService.deleteDwelling(event.id);
      return emitter(state.copyWith(status: DwellingStatus.delete));
    } catch (e) {
      emitter(state.copyWith(status: DwellingStatus.failure));
    }
  }
}
