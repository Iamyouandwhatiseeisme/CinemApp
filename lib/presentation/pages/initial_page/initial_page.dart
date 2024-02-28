// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect/multiselect.dart';

import '../../../data/data.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({
    super.key,
  });

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  void _updateSelectedGenres(List<Genre> genres) {
    setState(() {
      selectedGenres = genres;
    });
  }

  void _removeGenre(Genre genre, List<Genre> selectedGenres) {
    setState(() {
      selectedGenres.remove(genre);
    });
  }

  List<Genre> selectedGenres = [];
  Awards chosenAward = Awards.any;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: Text(
                  'Please Specify the qualities of the movie you are looking for'),
            ),
            const SizedBox(height: 80),
            const Text('Choose several genres'),
            ChooseMovieTypes(
              title: 'Please select desired genres',
              selectedGenres: selectedGenres,
              removeGenre: _removeGenre,
              updateGenre: _updateSelectedGenres,
            ),
            DropdownMenu<Awards>(
              initialSelection: Awards.any,
              dropdownMenuEntries:
                  Awards.values.map<DropdownMenuEntry<Awards>>((Awards awards) {
                return DropdownMenuEntry<Awards>(
                  value: awards,
                  label: awards.name,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Find',
        child: const Icon(Icons.search),
      ),
    );
  }
}

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
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: MultiSelectDialogField(
          chipDisplay: MultiSelectChipDisplay(
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
              .map((genre) => MultiSelectItem(genre,
                  '${genre.name.characters.first.toUpperCase()}${genre.name.substring(1)}'))
              .toList(),
          onConfirm: (values) {
            updateGenre(values);
          }),
    );
  }
}
