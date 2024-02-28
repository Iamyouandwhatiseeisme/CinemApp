// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinemapp/presentation/presentation.dart';
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
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: Text(
                    'Please Specify the qualities of the movie you are looking for'),
              ),
              const SizedBox(height: 20),
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(0.5),
              ),
              const Text(
                'Choose several genres',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              ChooseMovieTypes(
                title: 'Please select desired genres',
                selectedGenres: selectedGenres,
                removeGenre: _removeGenre,
                updateGenre: _updateSelectedGenres,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'What about academy awards?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomDropDownMenu(
                options: Awards.values,
                initialSelection: Awards.any,
              ),
            ],
          ),
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
