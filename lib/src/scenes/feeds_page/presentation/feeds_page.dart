import 'package:feeds_app/src/scenes/feeds_page/app/feeds_provider.dart';
import 'package:feeds_app/src/scenes/feeds_page/presentation/widgets/feed_box.dart';
import 'package:feeds_app/src/scenes/feeds_page/presentation/widgets/floating_create_button.dart';
import 'package:feeds_app/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  final ScrollController scrollController = ScrollController();

  bool isPageFull = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedsProvider>(context, listen: false).getFeeds();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >
              scrollController.position.maxScrollExtent - 25 &&
          !isPageFull) {
        Provider.of<FeedsProvider>(context, listen: false).increasePage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedsProvider>(
      builder: (BuildContext context, FeedsProvider value, Widget? child) {
        isPageFull = value.isPageFull;
        if (value.scrollToTop) {
          scrollController.jumpTo(0);
          value.clearScroll();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Feeds",
              style: TextStyle(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Consumer<FeedsProvider>(
                    builder: (BuildContext context, FeedsProvider value,
                        Widget? child) {
                      return ListView.builder(
                          controller: scrollController,
                          itemCount: value.feeds.length,
                          itemBuilder: (context, index) {
                            return FeedBox(
                              feed: value.feeds[index],
                              isLast: index == value.feeds.length - 1,
                              isLoading: value.pageLoading,
                            );
                          });
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: const FloatingCreateButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
