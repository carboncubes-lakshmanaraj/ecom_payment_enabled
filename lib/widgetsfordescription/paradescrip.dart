import 'package:flutter/material.dart';

class TextExpandableWidget extends StatefulWidget {
  final String text;

  const TextExpandableWidget({required this.text});

  @override
  _TextExpandableWidgetState createState() => _TextExpandableWidgetState();
}

class _TextExpandableWidgetState extends State<TextExpandableWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isExpanded ? null : 6, // Limit to 6 lines unless expanded
          overflow:
              _isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis, // Ellipsis when truncated
          style: textStyle,
        ),
        if (!_isExpanded) // Show the button only if not expanded
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },

            child: Text('More'),
          ),

        if (_isExpanded) // Show the button only if  expanded
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },

            child: Text('View less'),
          ),
      ],
    );
  }
}
