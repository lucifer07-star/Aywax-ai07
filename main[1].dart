
import 'package:flutter/material.dart';
import 'voice_service.dart';
import 'ml_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VoiceService _voiceService;
  late MLService _mlService;
  String _voiceInput = "";

  @override
  void initState() {
    super.initState();
    _voiceService = VoiceService();
    _mlService = MLService();
    _voiceService.initSpeech();
  }

  void _startVoice() {
    _voiceService.startListening((text) {
      setState(() {
        _voiceInput = text;
      });
    });
  }

  void _stopVoice() {
    _voiceService.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Aywax AI")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Voice Input: \$_voiceInput"),
            ElevatedButton(
              onPressed: _startVoice,
              child: const Text("Start Listening"),
            ),
            ElevatedButton(
              onPressed: _stopVoice,
              child: const Text("Stop Listening"),
            ),
            ElevatedButton(
              onPressed: () {
                String prediction = _mlService.predict(_voiceInput);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(content: Text(prediction)),
                );
              },
              child: const Text("Get AI Prediction"),
            )
          ],
        ),
      ),
    );
  }
}
