import 'package:alquilame/auth/auth.dart';
import 'package:alquilame/config/locator.dart';
import 'package:alquilame/create_credit_card/views/create_credit_card_page.dart';
import 'package:alquilame/create_dwelling/create_dwelling.dart';
import 'package:alquilame/credit_card/views/credit_card_page.dart';
import 'package:alquilame/dwelling/dwelling.dart';
import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/home/home.dart';
import 'package:alquilame/main.dart';
import 'package:alquilame/rest/rest_client.dart';
import 'package:alquilame/services/services.dart';
import 'package:alquilame/user_manage/user_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final UserResponse user;
  const HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alquilame"),
        backgroundColor: Colors.black87,
      ),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Viviendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Añadir',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        if (widget.user.role == "PROPIETARIO") {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(widget.user.avatar == null
                                  ? "https://simulacionymedicina.es/wp-content/uploads/2015/11/default-avatar-300x300-1.jpg"
                                  : "${ApiConstants.baseUrl}/download/${widget.user.avatar}"),
                            )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black),
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditAvatarPage(),
                                    ));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("${widget.user.fullName}",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text("${widget.user.email}",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfilePage(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(
                          "Editar mi perfil",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileList(
                        title: "Ver mis favoritas",
                        iconData: Icons.favorite,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DwellingFavouritesListPage(),
                              ));
                        }),
                    ProfileList(
                        title: "Ver mis viviendas",
                        iconData: Icons.home,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DwellingUserListPage(),
                              ));
                        }),
                    ProfileList(
                        title: "Editar Contraseña",
                        iconData: Icons.fingerprint,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditPasswordPage(),
                              ));
                        }),
                    ProfileList(
                        title: "Métodos de pago",
                        iconData: Icons.euro,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreditCardPage(),
                              ));
                        }),
                    ProfileList(
                      title: "Logout",
                      iconData: Icons.logout,
                      onPress: () async {
                        BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
                      },
                      textColor: Colors.red,
                    ),
                    ProfileList(
                      title: "Eliminar perfil",
                      iconData: Icons.delete_forever_outlined,
                      onPress: () async {
                        BlocProvider.of<AuthBloc>(context).add(UserDelete());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ));
                      },
                      textColor: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(widget.user.avatar == null
                                  ? "https://simulacionymedicina.es/wp-content/uploads/2015/11/default-avatar-300x300-1.jpg"
                                  : "http://localhost:8080/download/${widget.user.avatar}"),
                            )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black),
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditAvatarPage(),
                                    ));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("${widget.user.fullName}",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text("${widget.user.email}",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfilePage(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(
                          "Editar mi perfil",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileList(
                        title: "Ver mis favoritas",
                        iconData: Icons.favorite,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DwellingFavouritesListPage(),
                              ));
                        }),
                    ProfileList(
                        title: "Editar Contraseña",
                        iconData: Icons.fingerprint,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditPasswordPage(),
                              ));
                        }),
                    ProfileList(
                      title: "Logout",
                      iconData: Icons.logout,
                      onPress: () async {
                        BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
                      },
                      textColor: Colors.red,
                    ),
                    ProfileList(
                      title: "Eliminar perfil",
                      iconData: Icons.delete_forever_outlined,
                      onPress: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  '¿Quiéres eliminar esta vivienda de tu lista?'),
                              content: const Text(
                                  'Recuerda que esta acción no se puede deshacer.'),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    'CANCELAR',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  onPressed: () async {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(UserDelete());
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyApp(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "BORRAR",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      textColor: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          );
        }

      case 1:
        return BlocProvider(
          create: (context) {
            final dwellingService = getIt<DwellingService>();
            return DwellingBloc(dwellingService)..add(DwellingFetched());
          },
          child: const DwellingList(),
        );
      case 2:
        if (widget.user.role == "PROPIETARIO") {
          return const CreateDwellingPage();
        } else {
          return const Center(
            child: Text(
                "No puedes acceder al formulario de registro porque te registraste como inquilino."),
          );
        }
      default:
        throw Exception('Invalid index: $index');
    }
  }
}
