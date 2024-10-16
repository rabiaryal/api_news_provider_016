import 'package:api_provider_016/data/response/api_response.dart';
import 'package:api_provider_016/model/newsmodel.dart';
import 'package:api_provider_016/repository/home_api/home_repository.dart';
import 'package:flutter/foundation.dart';

class NewsProvider with ChangeNotifier {
  HomeRepository? homeRepository;

  NewsProvider({required this.homeRepository});

  ApiResponse<NewsModel> newsList = ApiResponse.loading();

  setNewsList(ApiResponse<NewsModel> response) {
    newsList = response;
    notifyListeners();
  }

  Future<void> fetchNewsListApi() async {
    setNewsList(ApiResponse.loading());

    try {
      final value = await homeRepository!.fetchNewsList();
      setNewsList(ApiResponse.completed(value));
    } catch (error) {
      setNewsList(ApiResponse.error(error.toString()));
    }
  }
}
