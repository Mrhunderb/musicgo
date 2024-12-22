import 'package:logger/logger.dart';

class MusicLogger {
  static final _logger = Logger();

  static void log(String message) {
    _logger.log(Level.info, message);
  }

  static void error(String message) {
    _logger.log(Level.error, message);
  }

  static void warning(String message) {
    _logger.log(Level.warning, message);
  }
}
