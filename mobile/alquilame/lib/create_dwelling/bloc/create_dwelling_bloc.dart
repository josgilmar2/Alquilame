import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/services/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateDwellingBloc extends FormBloc<String, String> {
  late final DwellingService _dwellingService;
  late PlatformFile file;

  final name = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final address = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final description = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final type = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: ['CASA', 'PISO', 'CHALET'],
  );

  final price = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final m2 = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final numBedrooms = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final numBathrooms =
      TextFieldBloc(validators: [FieldBlocValidators.required]);

  final hasElevator = BooleanFieldBloc();

  final hasPool = BooleanFieldBloc();

  final hasTerrace = BooleanFieldBloc();

  final hasGarage = BooleanFieldBloc();

  final provinceName = SelectFieldBloc(validators: [
    FieldBlocValidators.required
  ], items: [
    'A Coruna',
    'Alava',
    'Albacete',
    'Alicante',
    'Almeria',
    'Asturias',
    'Avila',
    'Badajoz',
    'Baleares',
    'Barcelona',
    'Bizkaia',
    'Burgos',
    'Caceres',
    'Cadiz',
    'Cantabria',
    'Castellon',
    'Ceuta',
    'Ciudad Real',
    'Cordoba',
    'Cuenca',
    'Guipuzkoa',
    'Girona',
    'Granada',
    'Guadalajara',
    'Huelva',
    'Huesca',
    'Jaen',
    'La Rioja',
    'Las Palmas',
    'Leon',
    'Lugo',
    'Lleida',
    'Madrid',
    'Malaga',
    'Melilla',
    'Murcia',
    'Navarra',
    'Ourense',
    'Palencia',
    'Pontevedra',
    'Salamanca',
    'Segovia',
    'Sevilla',
    'Soria',
    'Tarragona',
    'Tenerife',
    'Teruel',
    'Toledo',
    'Valencia',
    'Valladolid',
    'Zamora',
    'Zaragoza'
  ]);

  CreateDwellingBloc() {
    _dwellingService = getIt<DwellingService>();
    addFieldBlocs(fieldBlocs: [
      name,
      address,
      description,
      type,
      price,
      m2,
      numBedrooms,
      numBathrooms,
      hasElevator,
      hasPool,
      hasTerrace,
      hasGarage,
      provinceName
    ]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      await _dwellingService.createDwellingMultipart(
          DwellingRequest(
              name.value,
              address.value,
              description.value,
              type.value!,
              price.valueToDouble!,
              m2.valueToDouble!,
              numBedrooms.valueToInt!,
              numBathrooms.valueToInt!,
              hasElevator.value,
              hasPool.value,
              hasTerrace.value,
              hasGarage.value,
              provinceName.value!),
          file);
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }

  void saveImg(PlatformFile newFile) {
    file = newFile;
  }
}
