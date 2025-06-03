import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

/// 앱 전역에서 하나만 생성되어 사용하는 TTS 컨트롤러.
/// - isPlaying: TTS가 현재 재생 중인지 여부
/// - currentWord: 현재 재생 중인 단어
class TtsController extends GetxController {
  static TtsController get to => Get.find<TtsController>();
  late final FlutterTts _tts;

  /// TTS 재생 중이면 true, 아니면 false
  final RxBool isPlaying = false.obs;

  /// 현재 재생 중인 단어 (''이면 재생 중 아님)
  final RxString currentWord = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _tts = FlutterTts();

    // flutter_tts 4.2.3에서는 awaitSpeakCompletion 옵션을 설정해야
    // speak() 호출 후 onComplete 콜백이 정상 동작합니다.
    _tts.awaitSpeakCompletion(true);

    // 언어, 속도, 볼륨, 음조 등 기본 설정
    _tts.setLanguage('ko-KR');
    _tts.setSpeechRate(0.5);
    _tts.setVolume(1.0);
    _tts.setPitch(1.0);

    // 재생 완료 시 호출되는 콜백
    _tts.setCompletionHandler(() {
      isPlaying.value = false;
      currentWord.value = '';
    });

    // 에러 발생 시 호출되는 콜백
    _tts.setErrorHandler((msg) {
      isPlaying.value = false;
      currentWord.value = '';
    });
  }

  @override
  void onClose() {
    _tts.stop();
    super.onClose();
  }

  /// [word]를 TTS로 재생함.
  /// 이미 재생 중이면 먼저 중단 후 새로 재생.
  Future<void> speak(String word) async {
    // 동일한 단어가 이미 재생 중이면 아무 동작 안 함
    if (isPlaying.value && currentWord.value == word) return;
    // 다른 단어가 재생 중이라면 먼저 중단
    if (isPlaying.value) {
      await _tts.stop();
      // onComplete 콜백에서 isPlaying, currentWord가 자동으로 false/''로 변함
    }

    currentWord.value = word;
    isPlaying.value = true;
    await _tts.speak(word);
    // flutter_tts 설정상 awaitSpeakCompletion(true)를 설정했기 때문에,
    // speak()가 끝나면 setCompletionHandler가 반드시 호출됩니다.
  }

  /// 재생 중인 TTS 멈춤
  Future<void> stop() async {
    if (isPlaying.value) {
      await _tts.stop();
      isPlaying.value = false;
      currentWord.value = '';
    }
  }
}
