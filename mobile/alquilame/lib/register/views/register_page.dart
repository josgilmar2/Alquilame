import 'package:alquilame/login/login.dart';
import 'package:alquilame/main.dart';
import 'package:alquilame/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)))),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Regístrate"),
                backgroundColor: Colors.black87,
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              body: SafeArea(
                child: FormBlocListener<RegisterBloc, String, String>(
                  onSubmitting: (context, state) =>
                      RegisterDialog.show(context),
                  onSubmissionFailed: (context, state) =>
                      RegisterDialog.hide(context),
                  onSuccess: (context, state) {
                    RegisterDialog.hide(context);
                    if (state.stepCompleted == state.lastStep) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ));
                    }
                  },
                  onFailure: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "El número de teléfono tiene que ser de 9 cifras, las contraseñas tienen que ser de 8 caracteres o más con al menos una mayúscula, una minúscula, un número y un caracter especial o el nombre de usuario o email está escogido"),
                      duration: Duration(seconds: 10),
                    ));
                    RegisterDialog.hide(context);
                  },
                  child: StepperFormBlocBuilder<RegisterBloc>(
                      formBloc: context.read<RegisterBloc>(),
                      type: StepperType.horizontal,
                      physics: const ClampingScrollPhysics(),
                      stepsBuilder: (formBloc) {
                        return [_roleStep(formBloc!), _personalStep(formBloc)];
                      }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _roleStep(RegisterBloc registerBloc) {
    return FormBlocStep(
        title: const Text("¿Quieres ser propietario?"),
        content: SwitchFieldBlocBuilder(
          booleanFieldBloc: registerBloc.propietario,
          body: const Center(
            child: Text(
              "¿Quieres publicar tus propias viviendas en Alquilame? ¡Marca la opción y podrás hacerlo!",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ));
  }

  FormBlocStep _personalStep(RegisterBloc registerBloc) {
    return FormBlocStep(
        title: const Text("Tus Datos"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                  "https://dewey.tailorbrands.com/production/brand_version_mockup_image/222/8144028222_82dd4f72-f25a-4ff0-be13-94a4ed9d3fa9.png?cb=1676809534"),
            ),
            const SizedBox(height: 10),
            TextFieldBlocBuilder(
              decoration: const InputDecoration(
                  label: Text('Username'),
                  prefixIcon: Icon(Icons.person_2_outlined)),
              textFieldBloc: registerBloc.username,
              keyboardType: TextInputType.name,
            ),
            TextFieldBlocBuilder(
              decoration: const InputDecoration(
                label: Text('Email'),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              textFieldBloc: registerBloc.email,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFieldBlocBuilder(
              decoration: const InputDecoration(
                label: Text('Address'),
                prefixIcon: Icon(Icons.location_city_outlined),
              ),
              textFieldBloc: registerBloc.address,
              keyboardType: TextInputType.streetAddress,
            ),
            TextFieldBlocBuilder(
              decoration: const InputDecoration(
                label: Text('Phone Number'),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              textFieldBloc: registerBloc.phoneNumber,
              keyboardType: TextInputType.phone,
            ),
            TextFieldBlocBuilder(
              decoration: const InputDecoration(
                label: Text('Full Name'),
                prefixIcon: Icon(Icons.person_2_outlined),
              ),
              textFieldBloc: registerBloc.fullName,
              keyboardType: TextInputType.name,
            ),
            TextFieldBlocBuilder(
                decoration: const InputDecoration(
                  label: Text('Password'),
                  prefixIcon: Icon(Icons.fingerprint),
                ),
                textFieldBloc: registerBloc.password,
                keyboardType: TextInputType.visiblePassword,
                suffixButton: SuffixButton.obscureText),
            TextFieldBlocBuilder(
              decoration: const InputDecoration(
                label: Text('Verify Password'),
                prefixIcon: Icon(Icons.fingerprint),
              ),
              textFieldBloc: registerBloc.verifyPassword,
              keyboardType: TextInputType.visiblePassword,
              suffixButton: SuffixButton.obscureText,
            ),
          ],
        ));
  }
}

class RegisterDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => RegisterDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const RegisterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
