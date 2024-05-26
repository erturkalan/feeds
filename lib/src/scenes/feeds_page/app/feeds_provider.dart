import 'package:feeds_app/src/constants/user_feed_key.dart';
import 'package:feeds_app/src/scenes/feeds_page/data/dummy_data.dart';
import 'package:feeds_app/src/scenes/feeds_page/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class FeedsProvider extends ChangeNotifier {
  final feedBox = Hive.box(UserFeedKey.userFeedKey);

  bool isPageFull = false;
  bool scrollToTop = false;
  bool pageLoading = false;

  final List<FeedModel> _feeds = [];
  final List<FeedModel> _allFeeds = [];

  List<FeedModel> get feeds => _feeds;

  void getFeeds() {
    var feedList = <FeedModel>[];
    _feeds.clear();
    if (feedBox.values.isNotEmpty) {
      for (var element in feedBox.values) {
        var feed = FeedModel.fromMap(element);
        feedList.add(feed);
      }
      feedList.sort((a, b) => a.date.compareTo(b.date));
    }
    final adjustedList = feedList.reversed.toList();

    adjustedList.addAll(DummyData.dummyFeeds);

    _feeds.addAll(adjustedList.take(10));
    _allFeeds.addAll(adjustedList);
    notifyListeners();
  }

  void addFeed(FeedModel feed) async {
    _feeds.insert(0, feed);
    await feedBox.put(const Uuid().v1(), feed.toMap());
    getFeeds();
    isPageFull = false;
    scrollToTop = true;
    notifyListeners();
  }

  void increasePage() async {
    if (_feeds.length == _allFeeds.length) {
      isPageFull = true;
      return;
    }
    if (pageLoading) return;
    pageLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final index = _feeds.indexOf(_feeds.last);
    _feeds.addAll(_allFeeds.skip(index + 1).take(10));
    pageLoading = false;
    notifyListeners();
  }

  void clearScroll() {
    scrollToTop = false;
  }
}
