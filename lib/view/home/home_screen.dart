import 'package:flutter/material.dart';
import 'package:api_provider_016/config/color/color.dart';
import 'package:api_provider_016/config/components/loadiingWidgets.dart';
import 'package:api_provider_016/data/response/status.dart';
import 'package:api_provider_016/view/home/widgets/logout_button_widgets.dart';

import 'package:api_provider_016/view/home/newdetailsscreen.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:api_provider_016/view_model/news_api_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsProvider newsProvider = GetIt.I<NewsProvider>();

  @override
  void initState() {
    super.initState();
    // Fetch the news list when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsProvider.fetchNewsListApi();
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
              return const Center(child: LoadingWidget()); // Show loading
            case Status.completed:
              if (value.newsList.data!.articles!.isEmpty) {
                return const Center(child: Text('No data found'));
              }
              return ListView.builder(
                itemCount: value.newsList.data!.articles!.length,
                itemBuilder: (context, index) {
                  final article = value.newsList.data!.articles![index];
                  return ListTile(
                    title: Text(article.title ?? 'No title'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailScreen(article: article)));
                    },
                  );
                },
              );
            case Status.error:
              return Center(
                  child: Text('Error: ${value.newsList.message}')); // Show error
            default:
              return Container(); // Default empty container if no status matches
          }
        }),
      ),
    );
  }
}
