import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading the JSON file
import '../widgets/app_drawer.dart';
import '../widgets/mood_rating_item.dart';
import 'mood_log_screen.dart'; // Import your MoodLogScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _moodEntries = []; // List to keep track of mood entries
  String? _quote; // Variable to store the random quote
  List<dynamic> _quotes = []; // List to store quotes from JSON

  @override
  void initState() {
    super.initState();
    _loadQuotes(); // Load quotes from the local file when screen is initialized
  }

  // Function to load quotes from the local JSON file
  Future<void> _loadQuotes() async {
    try {
      String data = await rootBundle.loadString('assets/quotes.json');
      List<dynamic> quotes = json.decode(data);

      setState(() {
        _quotes = quotes;
        _fetchRandomQuote(); // Fetch a random quote after loading
      });
    } catch (error) {
      setState(() {
        _quote = 'Error loading quotes';
      });
    }
  }

  // Function to fetch a random quote from the list
  void _fetchRandomQuote() {
    if (_quotes.isNotEmpty) {
      final random = Random();
      final randomQuote = _quotes[random.nextInt(_quotes.length)];
      setState(() {
        _quote = randomQuote['quote'];
      });
    }
  }

  void _logMood(String mood) {
    setState(() {
      _moodEntries.add(mood); // Add the mood to the entries list
    });

    // Show visual confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood logged: $mood')),
    );
  }

  void _navigateToMoodLog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MoodLogScreen(moodEntries: _moodEntries), // Pass mood entries
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mental Health Chatbot',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(), // Sidebar remains unchanged
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Functional Random Quote Generator
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          24.0), // Increased padding for better spacing
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center elements vertically
                        children: [
                          const Text(
                            'Quote of The Day', // Improved title text
                            style: TextStyle(
                              fontSize: 26, // Increased font size
                              fontWeight: FontWeight.bold, // Made the text bold
                              color: Colors.white, // Optional color change
                            ),
                          ),
                          const SizedBox(
                              height:
                                  20), // More spacing between the title and icon
                          Icon(
                            Icons.format_quote,
                            size: 64,
                            color: Colors.grey[
                                700], // Optional color change for the icon
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _quote ??
                                'Loading quote...', // Show fetched quote or loading message
                            style: const TextStyle(
                              fontSize:
                                  18, // Slightly larger font size for the quote
                              fontStyle:
                                  FontStyle.italic, // Italic style for quotes
                              color: Colors.white, // White color for the quote
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          // "Get New Quote" button with mood card-like style
                          Material(
                            elevation: 6, // Raised effect for the button
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: _fetchRandomQuote,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .grey[300], // Same color as mood cards
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Get New Quote',
                                  style: TextStyle(
                                    color: Colors
                                        .black, // Black text to match mood cards
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mood Rating',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),
            // Scrollable Mood Rating Component
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MoodRatingItem(
                    icon: Icons.sentiment_very_satisfied,
                    label: 'Happy',
                    onTap: () => _logMood('Happy'),
                  ),
                  MoodRatingItem(
                    icon: Icons.sentiment_satisfied,
                    label: 'Content',
                    onTap: () => _logMood('Content'),
                  ),
                  MoodRatingItem(
                    icon: Icons.sentiment_neutral,
                    label: 'Neutral',
                    onTap: () => _logMood('Neutral'),
                  ),
                  MoodRatingItem(
                    icon: Icons.sentiment_dissatisfied,
                    label: 'Sad',
                    onTap: () => _logMood('Sad'),
                  ),
                  MoodRatingItem(
                    icon: Icons.sentiment_very_dissatisfied,
                    label: 'Angry',
                    onTap: () => _logMood('Angry'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Center the "View Mood Log" button
            Center(
              child: ElevatedButton(
                onPressed: _navigateToMoodLog, // Navigate to mood log screen
                child: const Text('View Mood Log'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
