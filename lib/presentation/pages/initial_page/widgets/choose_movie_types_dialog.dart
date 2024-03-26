import 'package:cinemapp/data/data.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../main.dart';

class ChooseMovieTypes extends StatelessWidget {
  const ChooseMovieTypes({
    super.key,
    required this.selectedGenres,
    required this.removeGenre,
    required this.updateGenre,
    required this.title,
  });

  final List<Genre> selectedGenres;
  final void Function(Genre, List<Genre>) removeGenre;
  final void Function(List<Genre>) updateGenre;
  final String title;

  @override
  Widget build(BuildContext context) {
    final StringManager stringManager = sl.get<StringManager>();

    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: MultiSelectDialogField(
          buttonText: const Text('Tap here to choose genres'),
          chipDisplay: MultiSelectChipDisplay(
            scroll: true,
            scrollBar: HorizontalScrollBar(isAlwaysShown: true),
            items:
                selectedGenres.map((e) => MultiSelectItem(e, e.name)).toList(),
            onTap: (value) {
              removeGenre(value, selectedGenres);
            },
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          unselectedColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white,
          items: Genre.values
              .map((genre) => MultiSelectItem(
                  genre, stringManager.toCaiptalize(genre.value)))
              .toList(),
          onConfirm: (values) {
            updateGenre(values);
          }),
    );
  }
}
