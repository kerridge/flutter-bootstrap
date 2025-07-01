import 'models/log_level.dart';
import 'models/log_source.dart';

abstract interface class Logger {
  void registerSource(LogSource source);

  void setPersistentAttributes(Map<String, dynamic> attributes);

  void log(
    String message, {
    String name,
    LogLevel level = LogLevel.info,
    Object? error,
    Map<String, dynamic>? attributes,
  });
}

abstract interface class AnalyticEvent {
  String get name;

  Map<String, dynamic> get attributes;

  DateTime get timestamp => DateTime.now();

  AnalyticEventType get type;
}

enum AnalyticEventType {
  screenView, // Page/screen views
  userAction, // User interactions (clicks, form submissions, etc.)
  navigation, // Navigation between screens/pages
  performance, // Performance metrics, load times, API calls
  error, // Errors, crashes, exceptions
  session, // Session start/end, app lifecycle events
  engagement, // Time spent, scroll depth, content consumption
  funnel, // Funnel events, user journey
  conversion, // Goal completions, business outcomes
  system, // System-level events, background processes
}
