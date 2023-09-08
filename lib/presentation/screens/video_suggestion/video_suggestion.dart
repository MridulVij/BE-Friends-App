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
    'keyword4': 'https://www.youtube.com/watch?v=46dcNIIBiPo',
    'keyword5': 'https://www.youtube.com/watch?v=Fq5MsTdM8KE',
    'keyword6': 'https://www.youtube.com/watch?v=fcfL8iris84',
    'keyword7': 'https://www.youtube.com/watch?v=Yy8e4sw70ow&t=1s',
    'keyword8': 'https://www.youtube.com/watch?v=lAdp3nT4BFA',
    'keyword9': 'https://www.youtube.com/watch?v=M4eUO7oIY3M',
    'keyword10': 'https://www.youtube.com/watch?v=C_JkK4ifbQs',
    'keyword11': 'https://www.youtube.com/watch?v=HxuR0tjwveo',
    'keyword12': 'https://www.youtube.com/watch?v=LB4hpZy_heg',
    'keyword13': 'https://www.youtube.com/watch?v=Yy8e4sw70ow&t=1s',
    'keyword14': 'https://www.youtube.com/watch?v=C_JkK4ifbQs',
    'keyword15': 'https://www.youtube.com/watch?v=fcfL8iris84',
    'keyword16': 'https://www.youtube.com/watch?v=LB4hpZy_heg',
    'keyword17': 'https://www.youtube.com/watch?v=fcfL8iris84',
    'keyword18': 'https://www.youtube.com/watch?v=Fq5MsTdM8KE',
    'keyword19': 'https://www.youtube.com/watch?v=Yy8e4sw70ow&t=1s',
    'keyword20': 'https://www.youtube.com/watch?v=Yy8e4sw70ow&t=1s',
    'keyword21': 'https://www.youtube.com/watch?v=LB4hpZy_heg',

    // Add more keyword-video URL pairs as needed
  };

  List<String> fitnessFAQs = [
    'WHAT is Anxiety and HOW to Deal with it',
    'Do you have suicidal thoughts? Extreme Depression',
    'Youtubers cannot Solve your Depression',
    'Bhagwan ka naam lo aur Kaam karo ',
    'How to get out from depression',
    "Understanding and Overcoming Depression: A Comprehensive Guide",
    "Anxiety Unmasked: Strategies for Coping and Prevention",
    "Breaking the Silence: Suicide Prevention and Mental Health Awareness",
    "The Power of Resilience: Building Mental Strength Against Depression",
    "Mental Health Matters: A Guide to Preventing Depression and Anxiety",
    "Suicide Prevention: Recognizing the Signs and Taking Action",
    "Managing Stress and Anxiety: Techniques for a Balanced Life",
    "Hope in Darkness: Stories of Triumph Over Depression",
    "Coping with Crisis: Strategies for Preventing Suicidal Thoughts",
    "Embracing Life: A Journey from Depression to Happiness",
    "Mindfulness and Mental Health: Tools for Anxiety and Depression Prevention",
    "Suicide Prevention in Teens: A Parent's Guide",
    "Finding Light in the Shadows: Overcoming Depression and Despair",
    "Building Resilience: A Path to Preventing Depression and Anxiety",
    "Reclaiming Your Joy: Strategies for Beating Depression",
    "Anxiety-Free Living: Techniques for a Calmer Mind",
    "Supporting Loved Ones: A Guide to Suicide Prevention",
    "Healing from Within: Self-Care Strategies for Mental Wellness",
    "The Road to Recovery: Overcoming Depression and Anxiety",
    "Promoting Mental Health: Strategies for a Happy Life",
    "Navigating Life's Challenges: Preventing Depression and Anxiety",
    "Breaking the Silence: Suicide Prevention and Mental Health Awareness",
    "Understanding Depression: Signs, Symptoms, and Solutions",
    "Anxiety Relief Techniques: Finding Calm in the Chaos",
    "Building Resilience: Strategies for Mental Health and Well-being",
    "The Power of Positivity: Overcoming Depression and Anxiety",
    "You Are Not Alone: Stories of Hope in Mental Health",
    "Suicide Prevention: Recognizing the Signs and Taking Action",
    "Mental Health Matters: Coping with Depression and Anxiety",
    "Mindfulness for Mental Health: Techniques to Stay Grounded",
    "Supporting Loved Ones: A Guide to Suicide Prevention",
    "Coping with Crisis: Strategies for Preventing Suicidal Thoughts",
    "Finding Joy in Everyday Life: Beating Depression and Anxiety",
    "Breaking Free from Depression: Steps to Recovery",
    "Anxiety Management: Tips for a Peaceful Mind",
    "Suicide Prevention in Teens: A Parent's Guide",
    "Healing from Within: Self-Care for Mental Wellness",
    "Resilient Minds: Overcoming Mental Health Challenges",
    "Living a Life of Purpose: Beating Depression and Finding Happiness",
    "Mind Over Mood: Your Guide to Conquering Depression and Anxiety",
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
            title: Text("BE Friends"),
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
                                    // here is a problem
                                    String? videoLink = keywordToVideoMap[
                                        keywordToVideoMap.keys.first];
                                    if (videoLink != null) {
                                      launchUrl(
                                        Uri.parse(videoLink),
                                      );
                                    }
                                    // print(keywordToVideoMap.keys.);
                                    print(videoLink);
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
                                              fontSize: 12,
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
                                      String? videoLink = keywordToVideoMap[
                                          keywordToVideoMap.values];
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
                                                fontSize: 11,
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
