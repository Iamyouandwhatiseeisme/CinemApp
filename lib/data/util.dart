class Util {
  String addCommas(int number) {
    String numberStr = number.toString();
    int length = numberStr.length;

    if (length <= 3) {
      return numberStr;
    }

    int firstCommaIndex = length % 3;

    if (firstCommaIndex == 0) {
      firstCommaIndex = 3;
    }

    String result = numberStr.substring(0, firstCommaIndex);

    for (int i = firstCommaIndex; i < length; i += 3) {
      result += ',${numberStr.substring(i, i + 3)}';
    }

    return result;
  }

  Future<List<String>> extractMovieNames(List<String> data) async {
    final movieList = <String>[];
    for (final movie in data) {
      final parts = movie.split('-');
      for (final part in parts) {
        if (part.trim().contains('Title:** ')) {
          final movieName = part.trim().split('** ').last;
          movieList.add(movieName);
          break; // Stop searching after finding TMDB ID
        }
        if (part.trim().contains('Title: ')) {
          final movieName = part.trim().split('Title: ').last;
          movieList.add(movieName);
          break;
        }
      }
    }
    return movieList;
  }

  List<String> extractMovieName(List<String> data) {
    final movieList = <String>[];
    for (final movie in data) {
      final parts = movie.split('-');
      for (final part in parts) {
        if (part.trim().contains('Title:** ')) {
          final movieName = part.trim().split('** ').last;
          movieList.add(movieName);
          break; // Stop searching after finding TMDB ID
        }
        if (part.trim().contains('Title: ')) {
          final movieName = part.trim().split('Title: ').last;
          movieList.add(movieName);
          break;
        }
      }
    }
    return movieList;
  }
}
