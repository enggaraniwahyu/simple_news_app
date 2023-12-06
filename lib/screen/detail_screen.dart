import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_news_app/models/article_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context, article),
              const SizedBox(
                height: 16,
              ),
              _content(article),
            ],
          ),
        ),
      ),
    );
  }

  Stack _header(BuildContext context, Article article) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          height: 250,
          width: double.infinity,
          child: Image.network(
            article.urlToImage ??
                "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await Share.share(article.url ?? "no url");
                },
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 210, left: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          width: 180,
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/people.jpg'),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  article.author ?? "Anonimous",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Container _content(Article article) {
    String? date = article.publishedAt;
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateFormat hourFormat = DateFormat('dd MMM yyyy');
    String formattedDate = dateFormat.format(DateTime.parse(date!));
    String formattedHour = hourFormat.format(DateTime.parse(date));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Health",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2EC5B6),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            article.title ?? "Judul Tidak Ada",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(formattedDate),
              const SizedBox(
                width: 8,
              ),
              const Text(
                '-',
              ),
              const SizedBox(
                width: 8,
              ),
              Text(formattedHour),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            article.description ?? "Tidak Ada Deskripsi",
            style: const TextStyle(
              height: 1.3,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
