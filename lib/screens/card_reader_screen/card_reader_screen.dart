import 'package:cc_assessment/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'camera_view.dart';

class TextRecogniserScreen extends StatefulWidget {
  const TextRecogniserScreen({required this.router, super.key});

  final GoRouter router;
  @override
  State<TextRecogniserScreen> createState() => _TextRecogniserScreenState();
}

class _TextRecogniserScreenState extends State<TextRecogniserScreen> {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      onImage: (inputImage) async {
        Map<String, dynamic>? data = await processImage(inputImage);
        if (data.containsKey('card_number')) {
          widget.router.go('/add_card', extra: data);
        }
      },
      router: widget.router,
    );
  }

  Map<String, dynamic> processTextBlocks(List<TextBlock> textBlocks) {
    String? cardNumber;
    for (final TextBlock textBlock in textBlocks) {
      for (final TextLine line in textBlock.lines) {
        String trimmed = line.text.removeAllWhitespace();
        if ((trimmed.length == 12 ||
                trimmed.length == 13 ||
                trimmed.length == 15 ||
                trimmed.length == 16 ||
                trimmed.length == 19) &&
            int.tryParse(trimmed) != null &&
            line.confidence! > 0.5) {
          cardNumber = trimmed;
          break;
        }
      }
      break;
    }
    if (cardNumber != null) {
      return {'card_number': cardNumber};
    }
    return {};
  }

  Future<Map<String, dynamic>> processImage(InputImage inputImage) async {
    if (!_canProcess) return {};
    if (_isBusy) return {};
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    final List<TextBlock> text = recognizedText.blocks;
    _isBusy = false;
    return processTextBlocks(text);
  }
}
