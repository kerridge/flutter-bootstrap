import '../models/log_event.dart';
import '../models/log_source.dart';

final class ConsoleLogSource implements LogSource {
  ConsoleLogSource() {
    _init();
  }

  void _init() {}

  @override
  String get name => 'ConsoleLogSource';

  final Map<String, dynamic> _persistentAttributes = {};

  @override
  void setPersistentAttributes(Map<String, dynamic> attributes) {
    _persistentAttributes.addAll(attributes);
  }

  @override
  void log(LogEvent logEvent) {
    print(logEvent.message);
  }
}
