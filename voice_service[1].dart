
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  late stt.SpeechToText _speech;
  bool isAvailable = false;

  VoiceService() {
    _speech = stt.SpeechToText();
  }

  Future<void> initSpeech() async {
    isAvailable = await _speech.initialize();
  }

  void startListening(Function(String) onResult) {
    if (isAvailable) {
      _speech.listen(onResult: (result) {
        onResult(result.recognizedWords);
      });
    }
  }

  void stopListening() {
    _speech.stop();
  }
}
