import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List articles = [];


  @override
  void initState() {
    super.initState();
     fetchNews();
  }

  Future<void> fetchNews() async {
    const String apiKey = '4812467692c24564a77a17a45b026c4d';
    const String url =
        'https://newsapi.org/v2/top-headlines?category=health&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = data['articles'];
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: article['urlToImage'] != null
                  ? Image.network(
                article['urlToImage'],
                width: 60,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.image_not_supported),
              title: Text(article['title'] ?? 'No title'),
              subtitle: Text(article['description'] ?? 'No description'),
              onTap: () {
                // Open article URL in a browser
                if (article['url'] != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Feature Coming Soon!'),
                      content: const Text(
                          'This feature will redirect to the full article.'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
