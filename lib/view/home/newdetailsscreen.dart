import 'package:api_provider_016/model/newsmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // Import url_launcher

class NewsDetailScreen extends StatefulWidget {
  final Articles article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool _isExpanded = false;  // State variable to track if the content is expanded

  @override
  void initState() {
    super.initState();
    // Print the content from the API to the console
    print('Content from API: ${widget.article.content}');
  }

  // Function to open the URL in the browser
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);  // Convert the string URL to a Uri object
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);  // Launch the URL in the external browser
    } else {
      throw 'Could not launch $url';  // Throw error if the URL cannot be opened
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title ?? 'News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.article.urlToImage != null &&
                  widget.article.urlToImage!.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: widget.article.urlToImage!,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey,  // Placeholder for missing image
                  child: const Center(child: Text('No Image Available')),
                ),
              const SizedBox(height: 16),
              Text(
                widget.article.title ?? 'No title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Source: ${widget.article.source?.name ?? 'Unknown source'}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Text(
                'Published at: ${widget.article.publishedAt ?? 'No date'}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Main content display
              Text(
                _isExpanded
                    ? widget.article.content ?? 'No content available'
                    : (widget.article.content?.length != null &&
                            widget.article.content!.length > 100
                        ? '${widget.article.content!.substring(0, 100)}...'
                        : widget.article.content ?? 'No content available'),
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
              const SizedBox(height: 16),

              // Displaying the character count
              if (widget.article.content != null)
                Text(
                  'Character count: ${widget.article.content!.length}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                )
              else
                const Text(
                  'No content available',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              const SizedBox(height: 16),

              // Toggle button for read more
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;  // Toggle expanded state
                  });
                },
                child: Text(_isExpanded ? 'Read Less' : 'Read More'),
              ),

              // Button to open the full article URL
              if (widget.article.url != null)
                TextButton.icon(
                  onPressed: () {
                    _launchUrl(widget.article.url!);  // Open the URL in browser
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Read Full Article'),
                )
              else
                const Text(
                  'No full article URL available',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
