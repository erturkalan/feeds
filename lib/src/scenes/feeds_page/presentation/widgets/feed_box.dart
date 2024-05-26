import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeds_app/src/constants/custom_shadow.dart';
import 'package:feeds_app/src/scenes/feed_detail_page/presentation/feed_detail_page.dart';
import 'package:feeds_app/src/scenes/feeds_page/model/feed_model.dart';
import 'package:feeds_app/utils/extensions/date_extension.dart';
import 'package:feeds_app/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class FeedBox extends StatelessWidget {
  const FeedBox({
    super.key,
    required this.feed,
    required this.isLast,
    required this.isLoading,
  });
  final FeedModel feed;
  final bool isLast;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedDetailPage(
              feed: feed,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    feed.header,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  feed.date.getFormattedDate,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colorScheme.surfaceTint,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [customBoxShadow]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.body,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(child: CachedNetworkImage(imageUrl: feed.image))
                  ],
                ),
              ),
            ),
            Visibility(
                visible: isLast && isLoading,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
