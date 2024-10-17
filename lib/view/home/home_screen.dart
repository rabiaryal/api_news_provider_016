import 'package:api_provider_016/config/components/network_image_widgets.dart';
import 'package:api_provider_016/view/home/newdetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:api_provider_016/config/color/color.dart';
import 'package:api_provider_016/config/components/loadiingWidgets.dart';
import 'package:api_provider_016/data/response/status.dart';
import 'package:api_provider_016/view/home/widgets/logout_button_widgets.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:api_provider_016/view_model/news_api_model.dart';

class HomeScreen extends StatefulWidget {
  final String apiUrl; // Accept the URL as a parameter

  const HomeScreen({super.key, required this.apiUrl});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsProvider newsProvider = GetIt.I<NewsProvider>();

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsProvider.fetchNewsListApi(url: widget.apiUrl); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        backgroundColor: AppColors.colorBlue,
        centerTitle: true,
        actions: const [
          LogoutButtonWidget(),
          SizedBox(width: 20),
        ],
      ),
      body: ChangeNotifierProvider<NewsProvider>.value(
        value: newsProvider,
        child: Consumer<NewsProvider>(builder: (context, value, _) {
          switch (value.newsList.status) {
            case Status.loading:
              return const Center(child: LoadingWidget()); 
            case Status.completed:
              if (value.newsList.data!.articles!.isEmpty) {
                return const Center(child: Text('No data found'));
              }
              return ListView.builder(
                itemCount: value.newsList.data!.articles!.length,
                itemBuilder: (context, index) {
                  final article = value.newsList.data!.articles![index];
                  return Card(
                    child: ListTile(
                      title: Text(article.title ?? 'No title'),
                      leading: NetworkImageWidget(
                        borderRadius: 6,
                        imageUrl: article.urlToImage.toString(),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailScreen(article: article)));
                      },
                    ),
                  );
                },
              );
            case Status.error:
              return Center(
                  child: Text('Error: ${value.newsList.message}')); // Show error
            default:
              return Container(); 
          }
        }),
      ),
    );
  }
}
