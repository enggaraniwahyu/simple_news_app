import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              const Icon(
                Icons.share,
                color: Colors.white,
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
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies. At tempor commodo ullamcorper a lacus vestibulum sed arcu. Elit eget gravida cum sociis. Integer feugiat scelerisque varius morbi enim nunc faucibus. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus non. Lacinia quis vel eros donec ac odio tempor. Morbi non arcu risus quis varius quam quisque. Ut ornare lectus sit amet est placerat in egestas erat.",
            style: TextStyle(
              height: 1.3,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 160,
            width: double.maxFinite,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Image.asset(
              'assets/images/map.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Doctor Reinhart explains the new variant of coronavirus",
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Euismod in pellentesque massa placerat duis ultricies. At tempor commodo ullamcorper a lacus vestibulum sed arcu. Elit eget gravida cum sociis. Integer feugiat scelerisque varius morbi enim nunc faucibus. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus non. Lacinia quis vel eros donec ac odio tempor. Morbi non arcu risus quis varius quam quisque. Ut ornare lectus sit amet est placerat in egestas erat.",
            style: TextStyle(
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
