import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_news_app/models/article_model.dart';
import 'package:simple_news_app/models/category_model.dart';
import 'package:simple_news_app/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiHeadline headline = ApiHeadline();
  ApiRecomendation recomendation = ApiRecomendation();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _categories(),
              const SizedBox(
                height: 12,
              ),
              _headline(),
              _trending(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const Icon(Icons.home),
      title: const Text(
        "Hello, Enggar",
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            _auth.signOut();
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  Container _card(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: category[index].color,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Icon(
              category[index].icon,
              size: 25.0,
              color: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category[index].title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  category[index].subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GridView _categories() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 10 / 4,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: category.length,
      itemBuilder: (context, index) => _card(index),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _headline() {
    return FutureBuilder(
      future: recomendation.getArticle(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Article>? articles = snapshot.data;
          return SizedBox(
            height: 265,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/detail',
                      arguments: articles[index]);
                },
                highlightColor: Colors.grey[200],
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.network(
                          articles[index].urlToImage ??
                              "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        articles[index].title ?? "Judul Tidak Ada",
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
                            DateFormat('dd MMM yyyy').format(DateTime.parse(
                                articles[index].publishedAt ??
                                    "Tanggal Tidak Ditemukan")),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 12,
              ),
              itemCount: articles!.length,
            ),
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

  Widget _trending() {
    return FutureBuilder(
      future: headline.getArticle(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Article>? articles = snapshot.data;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "|    Trending",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                                        DateFormat('HH:mm').format(
                                            DateTime.parse(
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
                                    "https://www.recia.fr/wp-content/uploads/2019/09/no_image.png",
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
            ),
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
