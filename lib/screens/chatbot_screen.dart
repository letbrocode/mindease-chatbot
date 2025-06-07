import 'package:chatbot_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<_ChatMessage> _messages = []; // Define the messages list
  final List<String> _conversationHistory =
      []; // Keep track of the full conversation

  // Add a message to the UI and optionally to the conversation history
  void _addMessage(String message,
      {bool isBot = false, bool addToHistory = true}) {
    setState(() {
      _messages.add(_ChatMessage(message, isBot: isBot));
      if (addToHistory) {
        _conversationHistory.add(isBot ? 'Bot: $message' : 'User: $message');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot'), centerTitle: true),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Talk to the Mental Health Bot',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            const SizedBox(height: 16),
            _MessageInput(onSend: _sendMessage), // Pass the send function
          ],
        ),
      ),
    );
  }

  // Modified send message function that includes conversation history
  Future<void> _sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return;

    // Add user message to the list and conversation history
    _addMessage(userMessage);

    // Replace with your ngrok URL
    String url = 'place your ngrok url here'; // Update with your ngrok URL

    try {
      // Prepare the conversation history and the new user message
      final requestBody = json.encode({
        'message': userMessage,
        'conversation_history':
            _conversationHistory, // Send full conversation history
      });

      // Send message to Flask API
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        String botResponse = json.decode(response.body)['response'];
        _addMessage(botResponse, isBot: true); // Add bot response to list
      } else {
        _addMessage("Error: ${response.reasonPhrase}", isBot: true);
      }
    } catch (e) {
      _addMessage("Error: $e", isBot: true);
    }
  }
}

class _ChatMessage extends StatelessWidget {
  final String message;
  final bool isBot;

  const _ChatMessage(this.message, {this.isBot = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Card(
        color: isBot
            ? Color.fromARGB(255, 30, 30, 30) // Dark gray for bot messages
            : Color.fromARGB(255, 70, 130, 180), // Steel blue for user messages
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _MessageInput extends StatefulWidget {
  final Function(String) onSend; // Callback function for sending messages

  const _MessageInput({required this.onSend, Key? key}) : super(key: key);

  @override
  __MessageInputState createState() => __MessageInputState();
}

class __MessageInputState extends State<_MessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: InputBorder.none,
              filled: true,
              fillColor:
                  const Color.fromARGB(255, 30, 30, 30), // Match the theme
            ),
            onFieldSubmitted: (value) {
              _sendMessage();
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _sendMessage,
          icon: const Icon(Icons.send),
          color: Colors.blue, // Match the theme
        ),
      ],
    );
  }

  void _sendMessage() {
    String userMessage = _controller.text;
    _controller.clear();
    widget.onSend(userMessage); // Call the send function
  }
}
