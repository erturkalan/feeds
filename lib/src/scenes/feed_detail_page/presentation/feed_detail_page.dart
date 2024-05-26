import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeds_app/src/scenes/feeds_page/model/feed_model.dart';
import 'package:feeds_app/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';

class FeedDetailPage extends StatelessWidget {
  const FeedDetailPage({super.key, required this.feed});

  final FeedModel feed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(feed.header),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(feed.body),
            const SizedBox(
              height: 10,
            ),
            Center(child: CachedNetworkImage(imageUrl: feed.image)),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(feed.date.getFormattedDate))
          ],
        ),
      ),
    );
  }
}
