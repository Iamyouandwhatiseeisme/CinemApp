import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey = dotenv.env['API_KEY']!;
  final GenerativeModel _model =
      GenerativeModel(model: 'gemini-pro', apiKey: dotenv.env['API_KEY']!);
  late final ChatSession chat;

  GeminiService() {
    init();
  }

  void init() {
    try {
      chat = _model.startChat();
    } on Exception catch (e) {
      throw (Exception(e));
    }
  }

  Future<String> sendChatMessage(String message) async {
    try {
      final response = await chat.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        return ('No response from API.');
      }
      return text;
    } catch (e) {
      rethrow;
    }
  }
}
