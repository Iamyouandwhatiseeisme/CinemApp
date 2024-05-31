import 'package:cinemapp/data/data.dart';
import 'package:flutter/material.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    required this.posterPath,
    required this.movieModel,
  });

  final String? posterPath;
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 2, style: BorderStyle.solid),
            color: Colors.blueGrey,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Builder(builder: (context) {
          if (posterPath != null) {
            return SizedBox(
              height: 300,
              width: 400,
              child: Image.network(
                fit: BoxFit.fill,
                posterPath!,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null),
                  );
                },
              ),
            );
          } else {
            return SizedBox(width: 400, child: Image.asset(posterPath!));
          }
        }),
      ),
    );
  }
}
