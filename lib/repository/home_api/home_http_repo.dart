



import 'package:api_provider_016/config/appurl.dart';
import 'package:api_provider_016/data/network/network_api_services.dart';
import 'package:api_provider_016/model/newsmodel.dart';
import 'package:api_provider_016/repository/home_api/home_repository.dart';


class HomeHttpApiRepository implements HomeRepository{

  final _apiServices = NetworkApiService() ;

  @override
  



  Future<NewsModel> fetchNewsList()async{
    dynamic response = await _apiServices.getGetApiResponse(AppUrl.baseUrl);
    return response = NewsModel.fromJson(response);
  }

 

}