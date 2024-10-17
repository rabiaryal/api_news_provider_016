import 'package:api_provider_016/model/newsmodel.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  final Articles article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool _isExpanded = false; // State variable to track if the content is expanded

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
              if (widget.article.urlToImage != null)
                Image.network(widget.article.urlToImage!),
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
                        (widget.article.content!.length > 100)
                        ? '${widget.article.content!.substring(0, 100)}...'
                        : widget.article.content ?? 'No content available'),
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
              const SizedBox(height: 16),
              // Displaying the character count
              Text(
                'Character count: ${widget.article.content?.length ?? 0}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              // Toggle button for read more
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded; // Toggle expanded state
                  });
                },
                child: Text(_isExpanded ? 'Read Less' : 'Read More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
