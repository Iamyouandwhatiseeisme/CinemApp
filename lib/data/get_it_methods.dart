import 'package:cinemapp/data/firestore/firestore_database.dart';
import 'package:cinemapp/main.dart';

import '../presentation/presentation.dart';
import 'data.dart';

void setUp() {
  sl.registerSingleton<NavigatorClient>(NavigatorClient());
  sl.registerSingleton<StringManager>(StringManager());
  sl.registerLazySingleton<GeminiService>(() => GeminiService());
  sl.registerSingleton<FireStoreDataBase>(FireStoreDataBase());
}
