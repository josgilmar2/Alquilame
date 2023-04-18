import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/services/services.dart';
import 'package:bloc/bloc.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final DwellingService _dwellingService;

  FavouriteBloc(DwellingService dwellingService)
      : assert(dwellingService != null),
        _dwellingService = dwellingService,
        super(const FavouriteState()) {
    on<AddFavourite>(_onAddFavourite);
    on<DeleteFavourite>(_onDeleteFavourite);
  }

  Future<void> _onAddFavourite(
      AddFavourite event, Emitter<FavouriteState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      if (state.status == FavouriteStatus.initial) {
        final dwellingFav = await _dwellingService.markAsFavourite(event.id);
        return emitter(state.copyWith(
            status: FavouriteStatus.success, dwelling: dwellingFav));
      }
    } catch (_) {
      emitter(state.copyWith(status: FavouriteStatus.failure));
    }
  }

  Future<void> _onDeleteFavourite(
      DeleteFavourite event, Emitter<FavouriteState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      if (state.status == FavouriteStatus.failure) {
        await _dwellingService.deleteFavourite(event.id);
        final dwelling = await _dwellingService.getOneDwelling(event.id);
        return emitter(state.copyWith(
            status: FavouriteStatus.initial, dwelling: dwelling));
      }
    } catch (_) {
      emitter(state.copyWith(status: FavouriteStatus.failure));
    }
  }
}
