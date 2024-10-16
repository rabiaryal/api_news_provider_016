import 'package:api_provider_016/repository/home_api/home_http_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:api_provider_016/view_model/news_api_model.dart';
import 'package:api_provider_016/repository/home_api/home_repository.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register HomeRepository
  getIt.registerLazySingleton<HomeRepository>(() => HomeHttpApiRepository());

  // Register NewsProvider and inject HomeRepository
  getIt.registerFactory<NewsProvider>(() => NewsProvider(homeRepository: null)..homeRepository = getIt<HomeRepository>());
}
