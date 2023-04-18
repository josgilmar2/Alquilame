import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingDetailBloc
    extends Bloc<DwellingDetailEvent, DwellingDetailState> {
  final DwellingService _dwellingService;

  DwellingDetailBloc(DwellingService dwellingService)
      : assert(dwellingService != null),
        _dwellingService = dwellingService,
        super(const DwellingDetailState()) {
    on<DwellingDetailFetched>(_onDwellingDetailFetched);
  }

  Future<void> _onDwellingDetailFetched(
      DwellingDetailFetched event, Emitter<DwellingDetailState> emitter) async {
    if (state.props.isEmpty) return;
    try {
      if (state.status == DwellingDetailStatus.initial) {
        final dwellingDetails = await _dwellingService.getOneDwelling(event.id);
        return emitter(state.copyWith(
            status: DwellingDetailStatus.success,
            dwellingDetail: dwellingDetails));
      }
    } catch (_) {
      emitter(state.copyWith(status: DwellingDetailStatus.failure));
    }
  }
}
