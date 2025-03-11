import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
     String url =
        'https://newsapi.org/v2/top-headlines?category=health&apiKey=${dotenv.env['newsAPIKey']}';

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
            color: Colors.white54,
            shadowColor: Colors.lightBlueAccent,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: article['urlToImage'] != null
                  ? SizedBox(
                height: 200,
                width: 150,
                    child: Image.network(
                       article['urlToImage'],
                       fit: BoxFit.fitHeight,
                      ),
                  )
                  : const Icon(Icons.image_not_supported),
              title: Text(article['title'] ?? 'No title',
                style: TextStyle(
                    fontFamily: 'Roboto',
                  fontSize: 16
                ),
              ),
              // subtitle: Text(article['description'] ?? 'No description'),
              onTap: () {

                showDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  context: context,
                  builder: (context) => AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.maxFinite,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.8, // Constrains height
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article['urlToImage'] != null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10,15,10,10),
                                child: Image.network(
                                  article['urlToImage'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article['title'] ?? 'No title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Aldrich',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['source']['name'] ?? 'No source',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Aldrich'
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['author'] ?? 'No source',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Aldrich'
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['description'] ?? 'No description available',
                                    style: const TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['publishedAt'] ?? 'No source',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      fontFamily: 'Dongle'
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                            'Close',
                                          style: TextStyle(
                                            color: Colors.cyan,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                
              },
            ),
          );
        },
      ),
    );
  }
}
