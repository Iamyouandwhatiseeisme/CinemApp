// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cinemapp/presentation/presentation.dart';

import '../../../data/data.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({
    super.key,
  });

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final TextEditingController movieLengthController = TextEditingController();
  final TextEditingController timePeriodController = TextEditingController();
  final TextEditingController prefferedActor = TextEditingController();

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

  @override
  void dispose() {
    prefferedActor.dispose();
    movieLengthController.dispose();
    timePeriodController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                    height: 5,
                  ),
                  const Text(
                    'What about academy awards?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomDropDownMenu(
                    options: Awards.values,
                    initialSelection: Awards.any,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Do you want the lead actor to be male or female?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const CustomDropDownMenu(
                      options: MainActorSex.values,
                      initialSelection: MainActorSex.any),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleFormFieldWithController(
                      hintText: 'How long do you want the movie to be?',
                      movieLengthController: movieLengthController),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleFormFieldWithController(
                      hintText:
                          'From what time period do you want the movie to be? (please specify a decade)',
                      movieLengthController: timePeriodController),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleFormFieldWithController(
                      hintText:
                          'Preffered actor/actress? (please include full name)',
                      movieLengthController: prefferedActor),
                ],
              ),
            ),
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
