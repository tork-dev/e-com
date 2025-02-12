import 'package:flutter/material.dart';
import 'package:kirei/src/utils/constants/colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLength = 150,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.text.length > widget.maxLength;
    final String displayText = _isExpanded || !isLongText
        ? widget.text
        : '${widget.text.substring(0, widget.maxLength)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
        ),
        if (isLongText)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? "View Less" : "View More",
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class Expandble extends StatefulWidget {
  const Expandble({super.key});

  @override
  State<Expandble> createState() => _ExpandbleState();
}

class _ExpandbleState extends State<Expandble> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

