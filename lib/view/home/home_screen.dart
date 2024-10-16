import 'package:api_provider_016/view/home/newdetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:api_provider_016/config/color/color.dart';
import 'package:api_provider_016/config/components/loadiingWidgets.dart';
import 'package:api_provider_016/config/components/network_image_widgets.dart';
import 'package:api_provider_016/data/response/status.dart';
import 'package:api_provider_016/view/home/widgets/home_error_widgets.dart';
import 'package:api_provider_016/view/home/widgets/logout_button_widgets.dart';// Import the detail screen
import 'package:api_provider_016/view_model/news_api_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the news list when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNewsListApi();
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
      body: ChangeNotifierProvider(
        create: (BuildContext context) => NewsProvider(),
        child: Consumer<NewsProvider>(builder: (context, value, _) {
          switch (value.newsList.status) {
            case Status.loading:
              return const Center(child: LoadingWidget());
            case Status.error:
              return const HomeErrorWidget();
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
                      leading: NetworkImageWidget(
                        borderRadius: 5,
                        imageUrl: article.urlToImage ?? '',
                      ),
                      title: Text(article.title ?? 'No title'),
                      subtitle: Text(article.source?.name ?? 'Unknown source'),
                      trailing: Text(article.publishedAt ?? 'No date'),
                      onTap: () {
                        // Navigate to the NewsDetailScreen on tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailScreen(article: article),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
