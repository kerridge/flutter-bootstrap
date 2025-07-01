import 'services/funnel_tracker.dart';

/// Example of how to use funnel tracking in a real checkout flow
class CheckoutFlowExample {
  /// Example: User starts checkout process
  void userStartsCheckout() {
    // User clicks "Proceed to Checkout" from cart
    CheckoutAnalyticsService.startCheckout(
      userId: 'user_123',
      sessionId: 'session_456',
      cartValue: 149.99,
    );

    // This creates a funnel event:
    // {
    //   "name": "funnel_step_completed",
    //   "type": "conversion",
    //   "attributes": {
    //     "funnel_id": "checkout",
    //     "funnel_name": "Checkout Flow",
    //     "step": {
    //       "step_number": 1,
    //       "step_name": "cart_review",
    //       "step_description": "User reviewed cart items",
    //       "step_data": {
    //         "cart_value": 149.99,
    //         "item_count": 3
    //       },
    //       "timestamp": "2024-01-15T10:30:00Z"
    //     },
    //     "user_id": "user_123",
    //     "session_id": "session_456"
    //   }
    // }
  }

  /// Example: User completes shipping info
  void userCompletesShipping() {
    // User fills out shipping form and clicks "Continue"
    CheckoutAnalyticsService.trackShippingInfoCompleted(
      shippingMethod: 'standard',
      country: 'US',
      shippingCost: 9.99,
    );

    // This creates another funnel event for step 2
  }

  /// Example: User selects payment method
  void userSelectsPayment() {
    // User selects credit card and clicks "Continue"
    CheckoutAnalyticsService.trackPaymentMethodSelected(
      paymentMethod: 'credit_card',
      isNewMethod: false,
    );
  }

  /// Example: User reviews order and goes back to change shipping
  void userGoesBackToChangeShipping() {
    // User is on order review page, clicks "Back" to shipping
    CheckoutAnalyticsService.trackBacktrack(
      fromStep: FunnelConstants.checkoutStep4, // order_review
      toStep: FunnelConstants.checkoutStep2, // shipping_info
      reason: 'user_changed_mind',
    );

    // This creates a backtrack event:
    // {
    //   "name": "funnel_backtrack",
    //   "type": "conversion",
    //   "attributes": {
    //     "funnel_id": "checkout",
    //     "funnel_name": "Checkout Flow",
    //     "from_step": {
    //       "step_number": 4,
    //       "step_name": "order_review",
    //       "step_description": "Backtracked from"
    //     },
    //     "to_step": {
    //       "step_number": 2,
    //       "step_name": "shipping_info",
    //       "step_description": "Backtracked to"
    //     },
    //     "reason": "user_changed_mind"
    //   }
    // }
  }

  /// Example: User changes shipping method and continues
  void userChangesShippingAndContinues() {
    // User changes shipping method and clicks "Continue" again
    CheckoutAnalyticsService.trackShippingInfoCompleted(
      shippingMethod: 'express',
      country: 'US',
      shippingCost: 19.99,
    );

    // This creates another step 2 completion event
  }

  /// Example: User completes order review
  void userCompletesOrderReview() {
    // User reviews final order and clicks "Place Order"
    CheckoutAnalyticsService.trackOrderReviewCompleted(
      totalAmount: 169.98,
      taxAmount: 12.50,
      discountAmount: 0.0,
    );
  }

  /// Example: Purchase is successful
  void purchaseSuccessful() {
    // Payment is processed successfully
    CheckoutAnalyticsService.trackPurchaseCompleted(
      orderId: 'order_789',
      totalAmount: 169.98,
      currency: 'USD',
    );

    // This creates a conversion event:
    // {
    //   "name": "conversion_completed",
    //   "type": "conversion",
    //   "attributes": {
    //     "conversion_type": "purchase",
    //     "value": 169.98,
    //     "currency": "USD",
    //     "funnel_id": "checkout",
    //     "completed_steps": [
    //       // All 5 steps with their data
    //     ],
    //     "total_time_to_conversion": 420, // 7 minutes
    //     "conversion_data": {
    //       "order_id": "order_789",
    //       "funnel_completion_rate": 100.0
    //     }
    //   }
    // }
  }

  /// Example: User abandons checkout
  void userAbandonsCheckout() {
    // User closes browser or navigates away
    CheckoutAnalyticsService.trackCheckoutAbandoned(
      lastStep: FunnelConstants.checkoutStep3, // payment_method
      reason: 'user_left',
    );

    // This creates an abandonment event:
    // {
    //   "name": "funnel_abandoned",
    //   "type": "conversion",
    //   "attributes": {
    //     "funnel_id": "checkout",
    //     "funnel_name": "Checkout Flow",
    //     "last_step": {
    //       "step_number": 3,
    //       "step_name": "payment_method",
    //       "step_description": "Abandoned at"
    //     },
    //     "abandonment_reason": "user_left",
    //     "time_spent_in_funnel": 180 // 3 minutes
    //   }
    // }
  }
}

/// Example of how to integrate this with Flutter widgets
/// In a real Flutter app, you would:
/// 1. Import 'package:flutter/material.dart'
/// 2. Extend StatefulWidget and State
/// 3. Call funnel tracking methods in initState, button handlers, and dispose
///
/// Example integration points:
/// - initState(): Start funnel tracking
/// - Button onPressed: Track step completion
/// - Back button: Track backtracking
/// - dispose(): Track abandonment if not completed

/// Example showing proper step timing
class ProperTimingExample {
  /// Example: Proper step timing in a real app
  void properStepTiming() {
    final funnel = FunnelTracker(
      funnelId: 'checkout',
      funnelName: 'Checkout Flow',
      userId: 'user_123',
      sessionId: 'session_456',
    );

    // 1. User enters shipping step
    funnel.startStep(2, 'shipping_info');

    // 2. User spends time filling out form...
    // (in real app, this would be actual user interaction time)

    // 3. User completes shipping step (e.g., clicks "Continue")
    funnel.completeStep(
      stepNumber: 2,
      stepName: 'shipping_info',
      stepDescription: 'User entered shipping information',
      stepData: {'shipping_method': 'express', 'country': 'US'},
    );

    // 4. User enters payment step
    funnel.startStep(3, 'payment_method');

    // 5. User spends time selecting payment method...

    // 6. User completes payment step
    funnel.completeStep(
      stepNumber: 3,
      stepName: 'payment_method',
      stepDescription: 'User selected payment method',
      stepData: {'payment_method': 'credit_card'},
    );

    // Now timeSpentOnCurrentStep will show actual time spent on each step
  }
}

/// Example of different abandonment scenarios
class AbandonmentScenarios {
  /// User gets an error and leaves
  void errorAbandonment() {
    CheckoutAnalyticsService.trackCheckoutAbandoned(
      lastStep: FunnelConstants.checkoutStep3,
      reason: 'payment_error',
    );
  }

  /// User gets distracted and times out
  void timeoutAbandonment() {
    CheckoutAnalyticsService.trackCheckoutAbandoned(
      lastStep: FunnelConstants.checkoutStep2,
      reason: 'session_timeout',
    );
  }

  /// User finds better price elsewhere
  void priceComparisonAbandonment() {
    CheckoutAnalyticsService.trackCheckoutAbandoned(
      lastStep: FunnelConstants.checkoutStep4,
      reason: 'price_comparison',
    );
  }

  /// User realizes they need to check something
  void researchAbandonment() {
    CheckoutAnalyticsService.trackCheckoutAbandoned(
      lastStep: FunnelConstants.checkoutStep1,
      reason: 'need_research',
    );
  }
}
