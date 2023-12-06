import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_news_app/models/article_model.dart';
import 'package:simple_news_app/models/category_model.dart';
import 'package:simple_news_app/services/api_services.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<ApiCategory> nameCategory = [
    ApiCategory('sports'),
    ApiCategory('health'),
    ApiCategory('entertainment'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _newsnotif(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const Icon(Icons.notifications_active),
      title: const Text(
        "Discover",
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  Container _newsnotif() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          SizedBox(
            height: 1100,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: category[index].color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            category[index].icon,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Latest News in ",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: category[index].title,
                                style: TextStyle(
                                  color: category[index].color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _news(nameCategory[index]),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: category.length - 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _news(ApiCategory categories) {
    return FutureBuilder(
      future: categories.getArticle(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Article>? articles = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: articles!.length.toDouble() * 100,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail',
                          arguments: articles[index]);
                    },
                    highlightColor: Colors.grey[200],
                    child: SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  articles[index].title ?? "Judul Tidak Ada",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(
                                              articles[index].publishedAt ??
                                                  "Tanggal Tidak Ditemukan")),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      '-',
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(DateTime.parse(
                                          articles[index].publishedAt ??
                                              "Tanggal Tidak Ditemukan")),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 86,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.network(
                              articles[index].urlToImage ??
                                  "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: articles.length,
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
