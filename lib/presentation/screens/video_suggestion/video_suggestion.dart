import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../route_names.dart';

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
    'keyword1': 'https://www.youtube.com/watch?v=XcPm87kd5bo',
    'keyword2': 'https://www.youtube.com/watch?v=zCTWQ8uF78s',
    'keyword3': 'https://www.youtube.com/watch?v=HciVBhstSQ4',
    'keyword4': 'https://www.youtube.com/watch?v=HciVBhstSQ4',
    // Add more keyword-video URL pairs as needed
  };

  List<String> fitnessFAQs = [
    'WHAT is Anxiety and HOW to Deal with it',
    'Do you have suicidal thoughts? Extreme Depression',
    'Youtubers CANNOT Solve your Depression',
    'Bhagwan ka naam lo aur Kaam karo '
        'How to get out from depression',
    'How to get rid from suicidal thoughts',
    'How to be motivated',
    // '091529 87821',
  ];

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
            setState(() {
              selectedVideoLink = "";
              matchQuery.clear();
              isNotFound = false;
            });
            return false;
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
          appBar: AppBar(
            title: Text('Suicide Prevention',style: TextStyle(fontWeight: FontWeight.bold),),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      search(value.trim());
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Enter Your Problem!",
                      suffix: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          search(searchController.text.trim());
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: selectedVideoLink.isNotEmpty
                      ? Container()
                      : matchQuery.isEmpty && !isNotFound
                      ? GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 10, // Vertical spacing
                      crossAxisSpacing: 10, // Horizontal spacing
                    ),
                    itemCount: fitnessFAQs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          String? videoLink =
                          keywordToVideoMap['keyword1'];
                          if (videoLink != null) {
                            launchUrl(
                              Uri.parse(videoLink),
                            );
                          }
                        },
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/1280px-YouTube_full-color_icon_%282017%29.svg.png",
                                  height: 40,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  fitnessFAQs[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                      : Visibility(
                    visible: !isNotFound,
                    replacement: ListTile(
                      title: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesName.chatbot);
                        },
                        child: const Text("Ask Question"),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        mainAxisSpacing: 10, // Vertical spacing
                        crossAxisSpacing: 10, // Horizontal spacing
                      ),
                      itemCount: matchQuery.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            String? videoLink =
                            keywordToVideoMap['keyword1'];
                            if (videoLink != null) {
                              launchUrl(
                                Uri.parse(videoLink),
                              );
                            }
                          },
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/1280px-YouTube_full-color_icon_%282017%29.svg.png",
                                    height: 40,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    matchQuery[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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