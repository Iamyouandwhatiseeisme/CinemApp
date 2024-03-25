import 'package:cinemapp/main.dart';

import '../presentation/presentation.dart';
import 'data.dart';

void setUp() {
  sl.registerSingleton<NavigatorClient>(NavigatorClient());
  sl.registerSingleton<StringManager>(StringManager());
  sl.registerLazySingleton<GeminiService>(() => GeminiService());
}
