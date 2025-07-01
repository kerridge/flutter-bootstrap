# Funnel & Conversion Tracking

A comprehensive system for tracking user journeys through multi-step processes and measuring business conversions.

## What are Funnels and Conversions?

### Funnels

A **funnel** is a series of steps that users follow toward a specific goal. Each step has a conversion rate - the percentage of users who proceed from one step to the next.

**Example Checkout Funnel:**

1. Cart Review (100% - all users start here)
2. Shipping Info (85% - 15% abandon)
3. Payment Method (70% - 15% abandon)
4. Order Review (60% - 10% abandon)
5. Purchase Complete (50% - 10% abandon)

### Conversions

A **conversion** is the successful completion of a business goal with associated value.

**Examples:**

- Purchase completed ($149.99)
- User signup (lifetime value: $500)
- Feature adoption (revenue impact: $25/month)

## Key Concepts

### 1. Step Progression

Track when users complete each step in your funnel:

```dart
funnelTracker.completeStep(
  stepNumber: 2,
  stepName: 'shipping_info',
  stepDescription: 'User entered shipping information',
  stepData: {
    'shipping_method': 'express',
    'country': 'US',
    'shipping_cost': 19.99,
  },
);
```

### 2. Backtracking

Users often go back to change previous steps:

```dart
funnelTracker.trackBacktrack(
  fromStepNumber: 4,
  fromStepName: 'order_review',
  toStepNumber: 2,
  toStepName: 'shipping_info',
  reason: 'user_changed_mind',
);
```

### 3. Abandonment

Track when users leave the funnel without completing:

```dart
funnelTracker.trackAbandonment(
  lastStepName: 'payment_method',
  abandonmentReason: 'payment_error',
);
```

### 4. Conversion

Track successful completion with business value:

```dart
funnelTracker.trackConversion(
  conversionType: 'purchase',
  value: 169.98,
  currency: 'USD',
  conversionData: {
    'order_id': 'order_789',
    'funnel_completion_rate': 100.0,
  },
);
```

## Event Schema

### FunnelStepEvent

```json
{
  "name": "funnel_step_completed",
  "type": "conversion",
  "attributes": {
    "funnel_id": "checkout",
    "funnel_name": "Checkout Flow",
    "step": {
      "step_number": 2,
      "step_name": "shipping_info",
      "step_description": "User entered shipping information",
      "step_data": {
        "shipping_method": "express",
        "country": "US",
        "shipping_cost": 19.99
      },
      "timestamp": "2024-01-15T10:30:00Z",
      "previous_step": "cart_review",
      "time_spent_on_previous_step": 45
    },
    "user_id": "user_123",
    "session_id": "session_456"
  }
}
```

### FunnelBacktrackEvent

```json
{
  "name": "funnel_backtrack",
  "type": "conversion",
  "attributes": {
    "funnel_id": "checkout",
    "funnel_name": "Checkout Flow",
    "from_step": {
      "step_number": 4,
      "step_name": "order_review",
      "step_description": "Backtracked from"
    },
    "to_step": {
      "step_number": 2,
      "step_name": "shipping_info",
      "step_description": "Backtracked to"
    },
    "reason": "user_changed_mind",
    "user_id": "user_123",
    "session_id": "session_456"
  }
}
```

### FunnelAbandonmentEvent

```json
{
  "name": "funnel_abandoned",
  "type": "conversion",
  "attributes": {
    "funnel_id": "checkout",
    "funnel_name": "Checkout Flow",
    "last_step": {
      "step_number": 3,
      "step_name": "payment_method",
      "step_description": "Abandoned at"
    },
    "abandonment_reason": "payment_error",
    "time_spent_in_funnel": 180,
    "user_id": "user_123",
    "session_id": "session_456"
  }
}
```

### ConversionEvent

```json
{
  "name": "conversion_completed",
  "type": "conversion",
  "attributes": {
    "conversion_type": "purchase",
    "value": 169.98,
    "currency": "USD",
    "funnel_id": "checkout",
    "completed_steps": [
      // All completed steps with their data
    ],
    "total_time_to_conversion": 420,
    "conversion_data": {
      "order_id": "order_789",
      "funnel_completion_rate": 100.0
    },
    "user_id": "user_123",
    "session_id": "session_456"
  }
}
```

## Usage Examples

### Checkout Flow

```dart
// 1. Start checkout funnel
final funnel = FunnelTracker(
  funnelId: 'checkout',
  funnelName: 'Checkout Flow',
  userId: 'user_123',
  sessionId: 'session_456',
);

// 2. User reviews cart
funnel.startStep(1, 'cart_review');
funnel.completeStep(
  stepNumber: 1,
  stepName: 'cart_review',
  stepDescription: 'User reviewed cart items',
  stepData: {'cart_value': 149.99, 'item_count': 3},
);

// 3. User enters shipping info
funnel.startStep(2, 'shipping_info');
funnel.completeStep(
  stepNumber: 2,
  stepName: 'shipping_info',
  stepDescription: 'User entered shipping information',
  stepData: {'shipping_method': 'express', 'country': 'US'},
);

// 4. User goes back to change shipping
funnel.trackBacktrack(
  fromStepNumber: 3,
  fromStepName: 'payment_method',
  toStepNumber: 2,
  toStepName: 'shipping_info',
  reason: 'user_changed_mind',
);

// 5. User completes purchase
funnel.trackConversion(
  conversionType: 'purchase',
  value: 169.98,
  currency: 'USD',
  conversionData: {'order_id': 'order_789'},
);
```

### Signup Flow

```dart
final signupFunnel = FunnelTracker(
  funnelId: 'signup',
  funnelName: 'User Registration',
  userId: null, // Not logged in yet
  sessionId: 'session_789',
);

// Email entry
signupFunnel.completeStep(
  stepNumber: 1,
  stepName: 'email_entry',
  stepDescription: 'User entered email address',
);

// Email verification
signupFunnel.completeStep(
  stepNumber: 2,
  stepName: 'email_verification',
  stepDescription: 'User verified email address',
);

// Profile setup
signupFunnel.completeStep(
  stepNumber: 3,
  stepName: 'profile_setup',
  stepDescription: 'User completed profile setup',
  stepData: {'has_profile_picture': true, 'completed_fields': 5},
);

// Signup complete
signupFunnel.trackConversion(
  conversionType: 'signup',
  value: 500.0, // Estimated lifetime value
  currency: 'USD',
  conversionData: {'signup_method': 'email'},
);
```

## Common Funnel Types

### 1. E-commerce Funnels

- **Checkout**: Cart → Shipping → Payment → Review → Purchase
- **Product Discovery**: Search → Browse → View → Add to Cart
- **Account Creation**: Guest → Signup → Verification → Profile

### 2. SaaS Funnels

- **Onboarding**: Welcome → Permissions → Tutorial → First Use
- **Feature Adoption**: Discovery → Trial → Setup → Regular Use
- **Upgrade**: Free → Trial → Paid Plan

### 3. Content Funnels

- **Content Consumption**: Discovery → View → Engage → Share
- **Newsletter**: Visit → Subscribe → Confirm → Receive
- **Download**: Landing → Form → Download → Install

## Abandonment Reasons

Track why users abandon funnels:

### Technical Reasons

- `payment_error` - Payment processing failed
- `validation_error` - Form validation failed
- `network_error` - Connection issues
- `session_timeout` - Session expired

### User Behavior

- `user_left` - User closed browser/app
- `user_changed_mind` - User decided not to proceed
- `price_comparison` - User checking other options
- `need_research` - User needs more information
- `distraction` - User got distracted

### Business Reasons

- `shipping_too_expensive` - Shipping cost was too high
- `payment_method_unavailable` - Preferred payment not available
- `out_of_stock` - Item became unavailable
- `terms_unacceptable` - Terms were not acceptable

## Analytics Insights

### Conversion Rate Analysis

- **Step-by-step conversion rates**: Identify where users drop off
- **Time to conversion**: How long successful users take
- **Backtracking patterns**: Which steps users revisit most
- **Abandonment reasons**: Why users leave and when

### Optimization Opportunities

- **High abandonment steps**: Focus improvement efforts
- **Common backtracking**: Simplify or clarify those steps
- **Time bottlenecks**: Steps that take too long
- **Error patterns**: Technical issues causing abandonment

### Business Impact

- **Revenue attribution**: Value of each funnel
- **Customer acquisition cost**: Cost per conversion
- **Lifetime value**: Long-term value of converted users
- **Funnel ROI**: Return on funnel optimization efforts

## Best Practices

### 1. Define Clear Steps

- Each step should have a clear, measurable completion criteria
- Avoid too many or too few steps
- Use descriptive step names and descriptions

### 2. Track Meaningful Data

- Include relevant business data in step_data
- Track time spent on each step
- Record user context (device, location, etc.)

### 3. Handle Edge Cases

- Track backtracking to understand user behavior
- Record abandonment reasons for optimization
- Handle errors gracefully with proper tracking

### 4. Maintain Consistency

- Use consistent funnel IDs and step names
- Standardize abandonment reason codes
- Follow the same tracking pattern across funnels

### 5. Privacy Compliance

- Don't track sensitive information in step_data
- Respect user privacy preferences
- Comply with GDPR, CCPA, and other regulations

## Integration with Analytics Platforms

### Mixpanel

- Funnel analysis shows step-by-step conversion rates
- Cohort analysis tracks conversion over time
- A/B testing compares funnel variations

### Google Analytics 4

- Enhanced e-commerce tracks purchase funnels
- Goal funnels track custom conversion paths
- User journey analysis shows complete paths

### Custom Analytics

- Build custom dashboards for funnel visualization
- Set up alerts for conversion rate drops
- Create automated reports for stakeholders

This funnel tracking system provides comprehensive insights into user behavior and business performance, enabling data-driven optimization of conversion paths.
