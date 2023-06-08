import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingDetailBloc
    extends Bloc<DwellingDetailEvent, DwellingDetailState> {
  final DwellingService _dwellingService;
  final JwtAuthService _jwtAuthService;

  DwellingDetailBloc(
      DwellingService dwellingService, JwtAuthService jwtAuthService)
      : assert(dwellingService != null),
        assert(jwtAuthService != null),
        _dwellingService = dwellingService,
        _jwtAuthService = jwtAuthService,
        super(const DwellingDetailState()) {
    on<DwellingDetailFetched>(_onDwellingDetailFetched);
    on<RateEvent>(_onRateEvent);
  }

  Future<void> _onDwellingDetailFetched(
      DwellingDetailFetched event, Emitter<DwellingDetailState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      if (state.status == DwellingDetailStatus.initial) {
        final dwellingDetails = await _dwellingService.getOneDwelling(event.id);
        final userResponse = await _jwtAuthService.getCurrentUser();
        return emitter(state.copyWith(
            status: DwellingDetailStatus.success,
            dwellingDetail: dwellingDetails,
            userResponse: userResponse));
      }
    } catch (_) {
      emitter(state.copyWith(status: DwellingDetailStatus.failure));
    }
  }

  Future<void> _onRateEvent(
      RateEvent event, Emitter<DwellingDetailState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      final dwellingDetails = await _dwellingService.rateDwelling(
          event.id, event.score, event.comment);
      final userResponse = await _jwtAuthService.getCurrentUser();
      return emitter(state.copyWith(
          status: DwellingDetailStatus.success,
          dwellingDetail: dwellingDetails,
          userResponse: userResponse));
    } catch (_) {
      emitter(state.copyWith(status: DwellingDetailStatus.failure));
    }
  }
}
