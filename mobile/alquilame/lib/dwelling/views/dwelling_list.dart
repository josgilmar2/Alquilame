import 'package:alquilame/dwelling/dwelling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingList extends StatefulWidget {
  const DwellingList();

  @override
  State<DwellingList> createState() => _DwellingListState();
}

class _DwellingListState extends State<DwellingList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DwellingBloc, DwellingState>(
      builder: (context, state) {
        switch (state.status) {
          case DwellingStatus.failure:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Failed to fetch dwellings'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<DwellingBloc>().add(DwellingRefresh());
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.black87)),
                  child: const Text('Try again'),
                ),
              ],
            );
          case DwellingStatus.success:
            if (state.dwellings.isEmpty) {
              return const Center(child: Text('no films'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.dwellings.length
                    ? const CircularProgressIndicator()
                    : DwellingListItem(dwelling: state.dwellings[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.dwellings.length
                  : state.dwellings.length + 1,
              controller: _scrollController,
            );
          case DwellingStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case DwellingStatus.delete:
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
    if (_isBottom) context.read<DwellingBloc>().add(DwellingFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
