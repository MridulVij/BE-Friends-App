import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:guardians_suicide_prevention_app/AIChatBot/chat_messagesUI.dart';

class ChatModel extends StatefulWidget {
  const ChatModel({super.key});

  @override
  State<ChatModel> createState() => _ChatModelState();
}

class _ChatModelState extends State<ChatModel> {
  final TextEditingController _prompts = TextEditingController();
  final List<ChatMessageUI> _messages = [];
  List<String> responseList = [];

  @override
  void initState() {
    super.initState();
    ChatMessageUI opening = ChatMessageUI(
      text: 'This is a safe space, we can talk about your feelings safely',
      sender: 'Therapist',
    );
    setState(() {
      _messages.insert(0, opening);
    });
  }
  void _addMessage(String text, String sender) {
    ChatMessageUI message = ChatMessageUI(text: text, sender: 'User');
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> sendGptRequest(String userMessage) async {
    final apiKey = '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'; // Replace with your OpenAI API key
    final apiUrl = 'https://api.openai.com/v1/chat/completions';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final requestBody = {
      "model": "ft:gpt-3.5-turbo-0613:personal::7uaZtIr1",
      "messages": [
        {
          "role": "user",
          "content": userMessage,
        }
      ],
      //DO NOT CHANGE THESE PARAMETERS AT ALL !!!
      "temperature": 1.3,
      "max_tokens": 256,
      "top_p": 1,
      "frequency_penalty": 0.95,
      "presence_penalty": 1.1,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final assistantResponse = responseBody['choices'][0]['message']['content'];
      ChatMessageUI aimessage= ChatMessageUI(text: assistantResponse, sender: 'Therapist');

      setState(() {
        _messages.insert(0, aimessage);
      });

    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }



  Widget _text_field() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              maxLines: null,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _addMessage(value, 'User');
                  sendGptRequest(value);
                  _prompts.clear();
                }
              },
              controller: _prompts,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Open up, I will help you to the best of my abilities',
                hintStyle: TextStyle(color: Colors.grey[800]),
                contentPadding: EdgeInsets.only(left: 8),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (_prompts.text.isNotEmpty) {
              _addMessage(_prompts.text, 'User');
              sendGptRequest(_prompts.text);
              _prompts.clear();
            }
          },
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/AiChatModel/send1.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maddie GPT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/AiChatModel/ChatBg/chatBG.png'),
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  child: _text_field(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
