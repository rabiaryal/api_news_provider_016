import 'package:api_provider_016/config/components/internet_exception_widgets.dart';
import 'package:api_provider_016/data/response/api_response.dart';
import 'package:api_provider_016/view_model/news_api_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (context, provider, child){
          if(provider.newsList.message.toString() == 'No Internet Connection'){
            return InterNetExceptionWidget(onPress: (){
              provider.setNewsList(ApiResponse.loading());
              provider.fetchNewsListApi();
            });
          }else {
            return InkWell(
                onTap: (){
                  provider.setNewsList(ApiResponse.loading());
                  provider.fetchNewsListApi();
                },
                child: Center(child: Text(provider.newsList.message.toString())));
          }
        }
    );
  }
}