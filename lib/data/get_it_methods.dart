import 'package:cinemapp/main.dart';

import '../presentation/widgets/navigation/navigator_client.dart';

void setUp() {
  sl.registerSingleton<NavigatorClient>(NavigatorClient());
}
