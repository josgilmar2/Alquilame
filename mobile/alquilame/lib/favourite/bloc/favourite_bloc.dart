import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/services/services.dart';
import 'package:bloc/bloc.dart';

int page = 0;

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final DwellingService _dwellingService;
  final UserService _userService;

  FavouriteBloc(DwellingService dwellingService, UserService userService)
      : assert(dwellingService != null),
        assert(userService != null),
        _dwellingService = dwellingService,
        _userService = userService,
        super(const FavouriteState()) {
    on<AddFavourite>(_onAddFavourite);
    on<DeleteFavourite>(_onDeleteFavourite);
    on<DwellingFavouritesFetched2>(_onDwellingFavouritesFetched);
  }

  Future<void> _onAddFavourite(
      AddFavourite event, Emitter<FavouriteState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      if (!state.isFavourite) {
        final dwellingFav = await _dwellingService.markAsFavourite(event.id);
        return emitter(state.copyWith(
            status: FavouriteStatus.success,
            dwelling: dwellingFav,
            isFavourite: true));
      }
    } catch (_) {
      emitter(state.copyWith(status: FavouriteStatus.failure));
    }
  }

  Future<void> _onDeleteFavourite(
      DeleteFavourite event, Emitter<FavouriteState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      if (state.isFavourite) {
        await _dwellingService.deleteFavourite(event.id);
        return emitter(state.copyWith(
            status: FavouriteStatus.initial, isFavourite: false));
      }
    } catch (_) {
      emitter(state.copyWith(status: FavouriteStatus.failure));
    }
  }

  Future<void> _onDwellingFavouritesFetched(
      DwellingFavouritesFetched2 event, Emitter<FavouriteState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == FavouriteStatus.initial) {
        page = 0;
        final dwellings = await _userService.getUserFavouriteDwellings(page);
        return emitter(state.copyWith(
            status: FavouriteStatus.success,
            dwellings: dwellings.content,
            hasReachedMax: dwellings.totalPages - 1 <= page,
            isFavourite: true));
      }
      page += 1;
      final dwellings = await _userService.getUserFavouriteDwellings(page);
      emitter(state.copyWith(
          status: FavouriteStatus.success,
          dwellings: List.of(state.dwellings)..addAll(dwellings.content),
          hasReachedMax: dwellings.totalPages - 1 <= page,
          isFavourite: true));
    } catch (_) {
      emitter(state.copyWith(status: FavouriteStatus.failure));
    }
  }
}
