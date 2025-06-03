import 'package:logger/web.dart';

class LogManager {
  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // 스택트레이스에서 출력할 호출 깊이
      errorMethodCount: 8, // 에러 시 더 깊은 스택트레이스 출력
      lineLength: 80,
      colors: true, // 콘솔에서 컬러 출력 사용 여부
      printEmojis: true, // 프린트 앞에 이모지 출력 여부
      printTime: false, // 로그에 타임스탬프 붙일지 여부
    ),
    level: Level.debug, // 출력 레벨 설정 (debug, info, warning, error, wtf)
  );

  static void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void warning(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void wtf(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.wtf(message, time: time, error: error, stackTrace: stackTrace);
  }

  //
}
