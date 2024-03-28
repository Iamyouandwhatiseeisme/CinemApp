// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cinemapp/bloc/cubit/remote_data_base_cubit.dart';
import 'package:flutter/material.dart';

import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({
    super.key,
  });

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final TextEditingController movieLengthController =
      TextEditingController(text: 'Any');
  final TextEditingController timePeriodController =
      TextEditingController(text: 'Any time period');
  final TextEditingController prefferedActor = TextEditingController(
    text: 'Any Actor',
  );
  final TextEditingController mainActorSex =
      TextEditingController(text: 'Any gender');
  final TextEditingController prefferedAwards =
      TextEditingController(text: 'Doesn\' matter');
  late final GeminiService? geminiService;

  List<String> awards = [
    Awards.any.value,
    Awards.winner.value,
    Awards.nominee.value
  ];
  List<String> mainActor = [
    MainActorSex.any.value,
    MainActorSex.female.value,
    MainActorSex.male.value,
  ];

  @override
  void initState() {
    BlocProvider.of<RemoteDataBaseInitiate>(context).initiate();

    super.initState();
  }

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
    mainActorSex.dispose();
    prefferedAwards.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: SingleChildScrollView(
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
              CustomDropDownMenu(
                controller: prefferedAwards,
                options: awards,
                initialSelection: Awards.any.value,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Do you want the lead actor to be male or female?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              CustomDropDownMenu(
                  controller: mainActorSex,
                  options: mainActor,
                  initialSelection: MainActorSex.any.value),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'How long do you want the movie to be?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SimpleFormFieldWithController(
                  hintText: 'Please specify in minutes',
                  textController: movieLengthController),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'From what time period?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SimpleFormFieldWithController(
                  hintText: 'Please specify a decade',
                  textController: timePeriodController),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Preffered actor/actress? (please include full name)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SimpleFormFieldWithController(
                  hintText: 'Please include full name',
                  textController: prefferedActor),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await BlocProvider.of<RemoteDataBaseInitiate>(context)
              .sendInitialChatMessage(
            prefferedActor: prefferedActor.text,
            movieLength: movieLengthController.text,
            timePeriod: timePeriodController.text,
            selectedGenres: selectedGenres.toList(),
            mainActorSex: mainActorSex.text,
            prefferedAwards: prefferedAwards.text,
          );

          prefferedActor.clear();
          movieLengthController.clear();
          timePeriodController.clear();
          mainActor.clear();
          selectedGenres = [];
          mainActorSex.clear();
          prefferedAwards.clear();

          if (context.mounted) {
            Navigator.pushReplacementNamed(context, NavigatorClient.chatScreen);
          }
        },
        tooltip: 'Find',
        child: const Icon(Icons.search),
      ),
    );
  }
}
