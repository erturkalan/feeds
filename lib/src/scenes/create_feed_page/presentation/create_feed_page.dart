import 'package:feeds_app/src/scenes/feeds_page/app/feeds_provider.dart';
import 'package:feeds_app/src/scenes/feeds_page/model/feed_model.dart';
import 'package:feeds_app/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage(
      {super.key, required this.parentContext, required this.formKey});
  final BuildContext parentContext;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    String headerText = "";
    String bodyText = "";
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
        ),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0))),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Create New Feed",
                              style: TextStyle(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                initialValue: headerText,
                                onTapOutside: (_) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                maxLines: null,
                                maxLength: 50,
                                decoration: const InputDecoration(
                                  labelText: "Header",
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                onSaved: (val) => headerText = val!,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return "This field can not be empty";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 140),
                                child: TextFormField(
                                  initialValue: bodyText,
                                  onTapOutside: (_) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    labelText: "Body",
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                  onSaved: (val) => bodyText = val!,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "This field can not be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            formKey.currentState!.save();
            final feed = FeedModel(
                header: headerText,
                body: bodyText,
                date: DateTime.now().millisecondsSinceEpoch);
            Provider.of<FeedsProvider>(parentContext, listen: false)
                .addFeed(feed);
            Navigator.pop(context);
          },
          label: const Text(
            'Create',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: context.colorScheme.primary),
    );
  }
}
