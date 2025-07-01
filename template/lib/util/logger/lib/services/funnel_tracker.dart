import '../logger.dart';
import '../models/funnel_events.dart';

/// Manages funnel state and tracking for a user session
class FunnelTracker {
  final String funnelId;
  final String funnelName;
  final String? userId;
  final String? sessionId;

  final List<FunnelStep> _completedSteps = [];
  final Map<int, DateTime> _stepStartTimes = {};
  final DateTime _funnelStartTime;

  FunnelTracker({
    required this.funnelId,
    required this.funnelName,
    this.userId,
    this.sessionId,
  }) : _funnelStartTime = DateTime.now();

  /// Get the current step number (0 if no steps completed)
  int get currentStepNumber => _completedSteps.length;

  /// Get the total time spent in the funnel
  int get totalTimeSpent =>
      DateTime.now().difference(_funnelStartTime).inSeconds;

  /// Get all completed steps
  List<FunnelStep> get completedSteps => List.unmodifiable(_completedSteps);

  /// Start tracking a step (call when user enters a step)
  void startStep(int stepNumber, String stepName) {
    _stepStartTimes[stepNumber] = DateTime.now();
  }

  /// Complete a funnel step
  void completeStep({
    required int stepNumber,
    required String stepName,
    required String stepDescription,
    Map<String, dynamic>? stepData,
    Map<String, dynamic>? additionalData,
  }) {
    final now = DateTime.now();
    final stepStartTime = _stepStartTimes[stepNumber];
    final timeSpentOnCurrentStep = stepStartTime != null
        ? now.difference(stepStartTime).inSeconds
        : null;

    final step = FunnelStep(
      stepNumber: stepNumber,
      stepName: stepName,
      stepDescription: stepDescription,
      stepData: stepData,
      timestamp: now,
      previousStep: _completedSteps.isNotEmpty
          ? _completedSteps.last.stepName
          : null,
      timeSpentOnCurrentStep: timeSpentOnCurrentStep,
    );

    _completedSteps.add(step);

    // Create and emit funnel step event
    final event = FunnelStepEvent(
      funnelId: funnelId,
      funnelName: funnelName,
      step: step,
      userId: userId,
      sessionId: sessionId,
      additionalData: additionalData,
    );

    // Here you would send the event to your analytics service
    _emitEvent(event);
  }

  /// Track backtracking (user goes back to previous step)
  void trackBacktrack({
    required int fromStepNumber,
    required String fromStepName,
    required int toStepNumber,
    required String toStepName,
    String? reason,
  }) {
    final fromStep = FunnelStep(
      stepNumber: fromStepNumber,
      stepName: fromStepName,
      stepDescription: 'Backtracked from',
      timestamp: DateTime.now(),
    );

    final toStep = FunnelStep(
      stepNumber: toStepNumber,
      stepName: toStepName,
      stepDescription: 'Backtracked to',
      timestamp: DateTime.now(),
    );

    final event = FunnelBacktrackEvent(
      funnelId: funnelId,
      funnelName: funnelName,
      fromStep: fromStep,
      toStep: toStep,
      userId: userId,
      sessionId: sessionId,
      reason: reason,
    );

    _emitEvent(event);
  }

  /// Track funnel abandonment
  void trackAbandonment({
    required String lastStepName,
    String? abandonmentReason,
  }) {
    final lastStep = FunnelStep(
      stepNumber: currentStepNumber,
      stepName: lastStepName,
      stepDescription: 'Abandoned at',
      timestamp: DateTime.now(),
    );

    final event = FunnelAbandonmentEvent(
      funnelId: funnelId,
      funnelName: funnelName,
      lastStep: lastStep,
      userId: userId,
      sessionId: sessionId,
      abandonmentReason: abandonmentReason,
      timeSpentInFunnel: totalTimeSpent,
    );

    _emitEvent(event);
  }

  /// Track successful conversion
  void trackConversion({
    required String conversionType,
    required double value,
    String currency = 'USD',
    Map<String, dynamic>? conversionData,
  }) {
    final event = ConversionEvent(
      conversionType: conversionType,
      value: value,
      currency: currency,
      userId: userId,
      sessionId: sessionId,
      funnelId: funnelId,
      completedSteps: completedSteps,
      totalTimeToConversion: totalTimeSpent,
      conversionData: conversionData,
    );

    _emitEvent(event);
  }

  /// Emit an analytics event (override this to send to your analytics service)
  void _emitEvent(AnalyticEvent event) {
    // This would typically send to your analytics service
    // For now, we'll just print the event
    print('Funnel Event: ${event.name}');
    print('Attributes: ${event.attributes}');
  }
}

/// Predefined funnel constants for common flows
class FunnelConstants {
  // Checkout funnel
  static const String checkoutFunnel = 'checkout';
  static const String checkoutStep1 = 'cart_review';
  static const String checkoutStep2 = 'shipping_info';
  static const String checkoutStep3 = 'payment_method';
  static const String checkoutStep4 = 'order_review';
  static const String checkoutStep5 = 'confirmation';

  // Signup funnel
  static const String signupFunnel = 'signup';
  static const String signupStep1 = 'email_entry';
  static const String signupStep2 = 'verification';
  static const String signupStep3 = 'profile_setup';
  static const String signupStep4 = 'preferences';

  // Onboarding funnel
  static const String onboardingFunnel = 'onboarding';
  static const String onboardingStep1 = 'welcome';
  static const String onboardingStep2 = 'permissions';
  static const String onboardingStep3 = 'tutorial';
  static const String onboardingStep4 = 'completion';
}

/// Example usage for checkout flow
class CheckoutAnalyticsService {
  static FunnelTracker? _currentFunnel;

  /// Start checkout funnel tracking
  static void startCheckout({
    required String userId,
    required String sessionId,
    required double cartValue,
  }) {
    _currentFunnel = FunnelTracker(
      funnelId: FunnelConstants.checkoutFunnel,
      funnelName: 'Checkout Flow',
      userId: userId,
      sessionId: sessionId,
    );

    // Track cart review step
    _currentFunnel!.startStep(1, FunnelConstants.checkoutStep1);
    _currentFunnel!.completeStep(
      stepNumber: 1,
      stepName: FunnelConstants.checkoutStep1,
      stepDescription: 'User reviewed cart items',
      stepData: {
        'cart_value': cartValue,
        'item_count': 3, // example
      },
    );
  }

  /// Track shipping info completion
  static void trackShippingInfoCompleted({
    required String shippingMethod,
    required String country,
    required double shippingCost,
  }) {
    if (_currentFunnel == null) return;

    _currentFunnel!.startStep(2, FunnelConstants.checkoutStep2);
    _currentFunnel!.completeStep(
      stepNumber: 2,
      stepName: FunnelConstants.checkoutStep2,
      stepDescription: 'User entered shipping information',
      stepData: {
        'shipping_method': shippingMethod,
        'country': country,
        'shipping_cost': shippingCost,
      },
    );
  }

  /// Track payment method selection
  static void trackPaymentMethodSelected({
    required String paymentMethod,
    required bool isNewMethod,
  }) {
    if (_currentFunnel == null) return;

    _currentFunnel!.startStep(3, FunnelConstants.checkoutStep3);
    _currentFunnel!.completeStep(
      stepNumber: 3,
      stepName: FunnelConstants.checkoutStep3,
      stepDescription: 'User selected payment method',
      stepData: {'payment_method': paymentMethod, 'is_new_method': isNewMethod},
    );
  }

  /// Track order review
  static void trackOrderReviewCompleted({
    required double totalAmount,
    required double taxAmount,
    required double discountAmount,
  }) {
    if (_currentFunnel == null) return;

    _currentFunnel!.startStep(4, FunnelConstants.checkoutStep4);
    _currentFunnel!.completeStep(
      stepNumber: 4,
      stepName: FunnelConstants.checkoutStep4,
      stepDescription: 'User reviewed order details',
      stepData: {
        'total_amount': totalAmount,
        'tax_amount': taxAmount,
        'discount_amount': discountAmount,
      },
    );
  }

  /// Track successful purchase
  static void trackPurchaseCompleted({
    required String orderId,
    required double totalAmount,
    required String currency,
  }) {
    if (_currentFunnel == null) return;

    _currentFunnel!.trackConversion(
      conversionType: 'purchase',
      value: totalAmount,
      currency: currency,
      conversionData: {
        'order_id': orderId,
        'funnel_completion_rate': 100.0, // 5/5 steps completed
      },
    );

    _currentFunnel = null; // Clear the funnel
  }

  /// Track checkout abandonment
  static void trackCheckoutAbandoned({
    required String lastStep,
    String? reason,
  }) {
    if (_currentFunnel == null) return;

    _currentFunnel!.trackAbandonment(
      lastStepName: lastStep,
      abandonmentReason: reason,
    );

    _currentFunnel = null; // Clear the funnel
  }

  /// Track backtracking (user goes back to change something)
  static void trackBacktrack({
    required String fromStep,
    required String toStep,
    String? reason,
  }) {
    if (_currentFunnel == null) return;

    // Determine step numbers based on step names
    final stepNumbers = {
      FunnelConstants.checkoutStep1: 1,
      FunnelConstants.checkoutStep2: 2,
      FunnelConstants.checkoutStep3: 3,
      FunnelConstants.checkoutStep4: 4,
      FunnelConstants.checkoutStep5: 5,
    };

    _currentFunnel!.trackBacktrack(
      fromStepNumber: stepNumbers[fromStep] ?? 0,
      fromStepName: fromStep,
      toStepNumber: stepNumbers[toStep] ?? 0,
      toStepName: toStep,
      reason: reason,
    );
  }
}
