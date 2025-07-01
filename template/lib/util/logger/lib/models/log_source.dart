import 'log_event.dart';

abstract interface class LogSource {
  String get name;

  void setPersistentAttributes(Map<String, dynamic> attributes);

  void log(LogEvent logEvent);
}
