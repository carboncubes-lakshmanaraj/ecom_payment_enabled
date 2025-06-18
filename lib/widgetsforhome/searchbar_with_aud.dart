import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchbarWithAud extends StatefulWidget {
  const SearchbarWithAud({super.key});

  @override
  State<SearchbarWithAud> createState() => _SearchbarWithAudState();
}

class _SearchbarWithAudState extends State<SearchbarWithAud> {
  TextEditingController _searchController = TextEditingController();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (error) {
        setState(() {
          _isListening = false;
        });
        print('Speech recognition error: $error');
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _searchController.text = result.recognizedWords;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.search), // You can change this icon
                  onPressed: () {
                    // Your action here
                    // Handle search action here
                    print("Search button pressed: ${_searchController.text}");
                  },
                ),
                labelText: "Search any Product...",

                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    color: _isListening ? Colors.red : Colors.blue,
                  ),
                  onPressed: () {
                    if (_isListening) {
                      _speech.stop();
                      setState(() {
                        _isListening = false;
                      });
                    } else {
                      _startListening();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
