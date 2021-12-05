import 'package:get_it/get_it.dart';
import 'package:weekly_bible_trivia/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
