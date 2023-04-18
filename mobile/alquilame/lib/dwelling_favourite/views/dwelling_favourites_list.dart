import 'package:alquilame/dwelling/dwelling.dart';
import 'package:alquilame/dwelling_favourite/dwelling_favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingFavouritesList extends StatefulWidget {
  const DwellingFavouritesList({super.key});

  @override
  State<DwellingFavouritesList> createState() => _DwellingFavouritesListState();
}

class _DwellingFavouritesListState extends State<DwellingFavouritesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DwellingFavouritesBloc, DwellingFavouritesState>(
      builder: (context, state) {
        switch (state.status) {
          case DwellingFavouritesStatus.failure:
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('No tienes viviendas favoritas'),
                ),
              ],
            );
          case DwellingFavouritesStatus.success:
            if (state.dwellings.isEmpty) {
              return const Center(child: Text('no films'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.dwellings.length
                    ? const BottomLoader()
                    : DwellingListItem(dwelling: state.dwellings[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.dwellings.length
                  : state.dwellings.length + 1,
              controller: _scrollController,
            );
          case DwellingFavouritesStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DwellingFavouritesBloc>().add(DwellingFavouritesFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
