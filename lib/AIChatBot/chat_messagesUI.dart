import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class ChatMessageUI extends StatelessWidget {
  const ChatMessageUI({super.key, required this.text, required this.sender});
  final String text;
  final String sender;

  String getAvatarImagePath() {
    if (sender == 'User') {
      return 'assets/AiChatModel/DisplayPics/batman2.png';
    } else if (sender == 'Therapist') {
      return 'assets/AiChatModel/DisplayPics/therapist.png';
    } else {
      // Handle other senders or default avatar here.
      return 'assets/DisplayPics/default-avatar.png';
    }
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 16, bottom: 5),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(getAvatarImagePath()),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onLongPress: () => copyToClipboard(context, text),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 5, bottom: 5, right: 10, top: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
