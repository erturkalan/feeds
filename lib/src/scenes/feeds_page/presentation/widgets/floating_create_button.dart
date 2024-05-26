import 'package:feeds_app/src/scenes/create_feed_page/presentation/create_feed_page.dart';
import 'package:flutter/material.dart';

class FloatingCreateButton extends StatelessWidget {
  const FloatingCreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            context: context,
            builder: (c) {
              return CreateFeedPage(
                parentContext: context,
                formKey: formKey,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
