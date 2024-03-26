import 'package:cinemapp/bloc/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.chatController,
    required this.onSubmitted,
  });
  final Function onSubmitted;
  final TextEditingController chatController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (_) => onSubmitted(),
            controller: chatController,
            decoration: InputDecoration(
              hintText: 'Enter any further information',
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<RemoteDataBaseInitiate, RemoteDataBaseState>(
          builder: (context, state) {
            if (state is RemoteDatabaseLoaded) {
              return IconButton(
                onPressed: () async {
                  onSubmitted();
                },
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
