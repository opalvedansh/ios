# ZepWash Common Package

Shared Dart package containing models, services, and utilities for ZepWash mobile applications.

## Features

- **Freezed Data Models:** Immutable models with JSON serialization
- **Firebase Services:** Authentication, Firestore, Storage, FCM
- **Location Services:** Geocoding and distance calculations
- **Utilities:** Formatters, validators, constants, custom exceptions

## Installation

Add this package as a dependency in your Flutter app's `pubspec.yaml`:

```yaml
dependencies:
  zepwash_common:
    path: ../../packages/zepwash-common
```

## Usage

```dart
import 'package:zepwash_common/zepwash_common.dart';

// Use models
final customer = Customer(...);

// Use services
final authService = AuthService();
await authService.verifyPhoneNumber(...);

// Use formatters
final formatted = Formatters.currency(799); // ₹799

// Use validators
final error = Validators.phone('+91 98765 43210'); // null (valid)
```

## Models

- `User` - Base user model
- `Customer` - Customer profile with address and subscription
- `Staff` - Staff profile with area assignment
- `Area` - Service area with pricing
- `Cleaning` - Cleaning record
- `Complaint` - Customer complaint
- `Payment` - Payment transaction
- `Leave` - Staff leave request

## Services

- `AuthService` - Phone OTP authentication
- `FirestoreService` - Generic Firestore operations
- `StorageService` - File upload/download
- `FCMService` - Push notifications
- `LocationService` - Geocoding and distance calculation

## Development

```bash
# Get dependencies
flutter pub get

# Generate code (Freezed, JSON serialization)
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Analyze code
flutter analyze
```
