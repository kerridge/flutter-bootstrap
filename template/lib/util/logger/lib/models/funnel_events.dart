import '../logger.dart';

/// Represents a funnel step with metadata
class FunnelStep {
  final int stepNumber;
  final String stepName;
  final String stepDescription;
  final Map<String, dynamic>? stepData;
  final DateTime timestamp;
  final String? previousStep;
  final int? timeSpentOnCurrentStep; // in seconds

  FunnelStep({
    required this.stepNumber,
    required this.stepName,
    required this.stepDescription,
    this.stepData,
    required this.timestamp,
    this.previousStep,
    this.timeSpentOnCurrentStep,
  });

  Map<String, dynamic> toMap() => {
    'step_number': stepNumber,
    'step_name': stepName,
    'step_description': stepDescription,
    if (stepData != null) 'step_data': stepData,
    'timestamp': timestamp.toIso8601String(),
    if (previousStep != null) 'previous_step': previousStep,
    if (timeSpentOnCurrentStep != null)
      'time_spent_on_current_step': timeSpentOnCurrentStep,
  };
}

/// Funnel event that tracks user progression through a funnel
class FunnelStepEvent implements AnalyticEvent {
  final String funnelId;
  final String funnelName;
  final FunnelStep step;
  final String? userId;
  final String? sessionId;
  final Map<String, dynamic>? additionalData;

  FunnelStepEvent({
    required this.funnelId,
    required this.funnelName,
    required this.step,
    this.userId,
    this.sessionId,
    this.additionalData,
  });

  @override
  String get name => 'funnel_step_completed';

  @override
  AnalyticEventType get type => AnalyticEventType.funnel;

  @override
  DateTime get timestamp => step.timestamp;

  @override
  Map<String, dynamic> get attributes => {
    'funnel_id': funnelId,
    'funnel_name': funnelName,
    'step': step.toMap(),
    if (userId != null) 'user_id': userId,
    if (sessionId != null) 'session_id': sessionId,
    if (additionalData != null) ...additionalData!,
  };
}

/// Conversion event that tracks successful completion of a business goal
class ConversionEvent implements AnalyticEvent {
  final String conversionType;
  final double value;
  final String currency;
  final String? userId;
  final String? sessionId;
  final String? funnelId;
  final List<FunnelStep>? completedSteps;
  final int? totalTimeToConversion; // in seconds
  final Map<String, dynamic>? conversionData;

  ConversionEvent({
    required this.conversionType,
    required this.value,
    this.currency = 'USD',
    this.userId,
    this.sessionId,
    this.funnelId,
    this.completedSteps,
    this.totalTimeToConversion,
    this.conversionData,
  });

  @override
  String get name => 'conversion_completed';

  @override
  AnalyticEventType get type => AnalyticEventType.conversion;

  @override
  DateTime get timestamp => DateTime.now();

  @override
  Map<String, dynamic> get attributes => {
    'conversion_type': conversionType,
    'value': value,
    'currency': currency,
    if (userId != null) 'user_id': userId,
    if (sessionId != null) 'session_id': sessionId,
    if (funnelId != null) 'funnel_id': funnelId,
    if (completedSteps != null)
      'completed_steps': completedSteps!.map((s) => s.toMap()).toList(),
    if (totalTimeToConversion != null)
      'total_time_to_conversion': totalTimeToConversion,
    if (conversionData != null) ...conversionData!,
  };
}

/// Funnel backtracking event (when user goes back or changes previous step)
class FunnelBacktrackEvent implements AnalyticEvent {
  final String funnelId;
  final String funnelName;
  final FunnelStep fromStep;
  final FunnelStep toStep;
  final String? userId;
  final String? sessionId;
  final String? reason; // "user_changed_mind", "error_correction", etc.

  FunnelBacktrackEvent({
    required this.funnelId,
    required this.funnelName,
    required this.fromStep,
    required this.toStep,
    this.userId,
    this.sessionId,
    this.reason,
  });

  @override
  String get name => 'funnel_backtrack';

  @override
  AnalyticEventType get type => AnalyticEventType.funnel;

  @override
  DateTime get timestamp => DateTime.now();

  @override
  Map<String, dynamic> get attributes => {
    'funnel_id': funnelId,
    'funnel_name': funnelName,
    'from_step': fromStep.toMap(),
    'to_step': toStep.toMap(),
    if (userId != null) 'user_id': userId,
    if (sessionId != null) 'session_id': sessionId,
    if (reason != null) 'reason': reason,
  };
}

/// Funnel abandonment event
class FunnelAbandonmentEvent implements AnalyticEvent {
  final String funnelId;
  final String funnelName;
  final FunnelStep lastStep;
  final String? userId;
  final String? sessionId;
  final String? abandonmentReason; // "user_left", "error", "timeout", etc.
  final int? timeSpentInFunnel; // in seconds

  FunnelAbandonmentEvent({
    required this.funnelId,
    required this.funnelName,
    required this.lastStep,
    this.userId,
    this.sessionId,
    this.abandonmentReason,
    this.timeSpentInFunnel,
  });

  @override
  String get name => 'funnel_abandoned';

  @override
  AnalyticEventType get type => AnalyticEventType.funnel;

  @override
  DateTime get timestamp => DateTime.now();

  @override
  Map<String, dynamic> get attributes => {
    'funnel_id': funnelId,
    'funnel_name': funnelName,
    'last_step': lastStep.toMap(),
    if (userId != null) 'user_id': userId,
    if (sessionId != null) 'session_id': sessionId,
    if (abandonmentReason != null) 'abandonment_reason': abandonmentReason,
    if (timeSpentInFunnel != null) 'time_spent_in_funnel': timeSpentInFunnel,
  };
}
