import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  TextEditingController searchController = TextEditingController();

  List<String> matchQuery = [];
  bool isNotFound = false;

  Map<String, String> keywordToVideoMap = {
    'keyword1': 'https://www.youtube.com/watch?v=VIDEO_ID_1',
    'keyword2': 'https://www.youtube.com/watch?v=VIDEO_ID_2',
    // Add more keyword-video URL pairs as needed
  };

  String selectedVideoLink = "";

  void search(String query) {
    if (query.isEmpty) return;
    List<String> searchQuery = query.split(' ');
    List<String> filteredList = [];

    // Check if the query matches any predefined keywords
    for (String keyword in keywordToVideoMap.keys) {
      if (searchQuery.contains(keyword.toLowerCase())) {
        String? videoLink = keywordToVideoMap[keyword];
        // Set the selected video link
        setState(() {
          selectedVideoLink = videoLink ?? "";
        });
        return; // Stop further processing if a keyword match is found
      }
    }

    Map<String, int> faqMatchCounts = {};

    for (String faq in fitnessFAQs) {
      // Count the number of matched words in each FAQ
      int matchCount = searchQuery
          .where((term) => faq.toLowerCase().contains(term.toLowerCase()))
          .length;

      // Store the FAQ and its match count in the map
      faqMatchCounts[faq] = matchCount;
    }

    var sortedResults = faqMatchCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    filteredList = sortedResults.map((entry) {
      if (entry.value != 0) {
        return entry.key;
      }
      return "";
    }).toList();
    filteredList.removeWhere((faq) => faq == "");
    matchQuery.clear();
    matchQuery = filteredList;
    if (matchQuery.isEmpty) {
      isNotFound = true;
    } else {
      isNotFound = false;
    }

    // Clear the selected video link
    setState(() {
      selectedVideoLink = "";
    });

    setState(() {});
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (selectedVideoLink.isNotEmpty) {
            // Clear the selected video link and search results
            setState(() {
              selectedVideoLink = "";
              matchQuery.clear();
              isNotFound = false;
            });
            return false; // Prevent back navigation when a video is open
          } else if (matchQuery.isNotEmpty || isNotFound) {
            search("");
            matchQuery.clear();
            isNotFound = false;
            setState(() {});
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: searchController,
                  onFieldSubmitted: (value) {
                    search(value.trim());
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Problem for Video Solution!",
                    suffix: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        search(searchController.text.trim());
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: selectedVideoLink.isNotEmpty
                      ? ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                // Open the selected video link
                                launchUrl(
                                  Uri.parse(selectedVideoLink),
                                );
                              },
                              title: Text(
                                "Open Video",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        )
                      : matchQuery.isEmpty && !isNotFound
                          ? ListView.builder(
                              itemCount: fitnessFAQs.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    // Handle opening the video link here
                                    String? videoLink =
                                        keywordToVideoMap['keyword1'];
                                    if (videoLink != null) {
                                      launchUrl(
                                        Uri.parse(videoLink),
                                      );
                                    }
                                  },
                                  splashColor: Colors.grey,
                                  title: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/1280px-YouTube_full-color_icon_%282017%29.svg.png",
                                            height: 30,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            fitnessFAQs[index],
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            )
                          : Visibility(
                              visible: !isNotFound,
                              replacement: ListTile(
                                  title: TextButton(
                                onPressed: () {},
                                child: Text("Ask Question"),
                              )),
                              child: ListView.builder(
                                itemCount: matchQuery.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      String? videoLink =
                                          keywordToVideoMap['keyword1'];
                                      if (videoLink != null) {
                                        launchUrl(
                                          Uri.parse(videoLink),
                                        );
                                      }
                                    },
                                    splashColor: Colors.grey,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/1280px-YouTube_full-color_icon_%282017%29.svg.png",
                                            height: 30,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            matchQuery[index],
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> fitnessFAQs = [
  'How to get out from depression',
  'How to get rid from suicidal thoughts',
  'How to be motivated',
  'How to think positive'
];
