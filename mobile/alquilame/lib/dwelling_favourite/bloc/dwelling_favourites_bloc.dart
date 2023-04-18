import 'package:alquilame/dwelling_favourite/dwelling_favourite.dart';
import 'package:alquilame/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);
int page = 0;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class DwellingFavouritesBloc
    extends Bloc<DwellingFavouritesEvent, DwellingFavouritesState> {
  final UserService _userService;

  DwellingFavouritesBloc(UserService userService)
      : assert(userService != null),
        _userService = userService,
        super(const DwellingFavouritesState()) {
    on<DwellingFavouritesFetched>(_onDwellingFavouritesFetched);
  }

  Future<void> _onDwellingFavouritesFetched(DwellingFavouritesFetched event,
      Emitter<DwellingFavouritesState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DwellingFavouritesStatus.initial) {
        page = 0;
        final dwellings = await _userService.getUserFavouriteDwellings(page);
        return emitter(state.copyWith(
          status: DwellingFavouritesStatus.success,
          dwellings: dwellings.content,
          hasReachedMax: dwellings.totalPages - 1 <= page,
        ));
      }
      page += 1;
      final dwellings = await _userService.getUserFavouriteDwellings(page);
      emitter(state.copyWith(
          status: DwellingFavouritesStatus.success,
          dwellings: List.of(state.dwellings)..addAll(dwellings.content),
          hasReachedMax: dwellings.totalPages - 1 <= page));
    } catch (_) {
      emitter(state.copyWith(status: DwellingFavouritesStatus.failure));
    }
  }
}
