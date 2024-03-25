import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String apiKey = dotenv.env['TMDB_API_KEY']!;
}
