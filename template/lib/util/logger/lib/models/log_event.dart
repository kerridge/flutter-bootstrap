import 'log_level.dart';

final class LogEvent {
  final String message;
  final LogLevel level;
  final DateTime timestamp = DateTime.now();

  LogEvent({required this.message, this.level = LogLevel.info});
}
