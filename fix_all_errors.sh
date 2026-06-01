#!/bin/bash

echo "🔧 Starting automatic fixes for ZepWash Customer App..."
echo ""

cd /c/appdev/apps/customer_app

# Backup files before making changes
echo "📦 Creating backup..."
mkdir -p .backup_$(date +%Y%m%d_%H%M%S)
cp -r lib .backup_$(date +%Y%m%d_%H%M%S)/

# Fix 1: GoRouter state.location → state.matchedLocation
echo "1️⃣  Fixing GoRouter API (state.location → state.matchedLocation)..."
sed -i 's/state\.location/state.matchedLocation/g' lib/core/routes/app_router.dart

# Fix 2: Validator method calls - phone
echo "2️⃣  Fixing Validator.phone method calls..."
# In phone_input_screen.dart
sed -i '/if (!Validators\.isValidPhoneNumber(value))/,+2d' lib/features/auth/presentation/screens/phone_input_screen.dart
sed -i 's/return null;$/final phoneError = Validators.phone(value);\n                      if (phoneError != null) return phoneError;\n                      return null;/' lib/features/auth/presentation/screens/phone_input_screen.dart

# Fix 3: Validator method calls - plateCode
echo "3️⃣  Fixing Validator.plateCode method calls..."
# In signup_screen.dart - replace the validator logic
sed -i 's/if (!Validators\.isValidPlateCode(value)) {/final plateError = Validators.plateCode(value);/g' lib/features/auth/presentation/screens/signup_screen.dart
sed -i 's/return .Invalid plate code.;$/if (plateError != null) return plateError;/g' lib/features/auth/presentation/screens/signup_screen.dart

# Fix 4: Formatter method calls
echo "4️⃣  Fixing Formatter method names..."
sed -i 's/Formatters\.formatPhoneNumber/Formatters.phoneNumber/g' lib/features/home/presentation/widgets/staff_info_card.dart
sed -i 's/Formatters\.formatPhoneNumber/Formatters.phoneNumber/g' lib/features/profile/presentation/screens/profile_screen.dart
sed -i 's/Formatters\.formatDate/Formatters.date/g' lib/features/home/presentation/screens/home_screen.dart

# Fix 5: Remove unused cloud_firestore import
echo "5️⃣  Removing unused imports..."
sed -i '/^import.*cloud_firestore.*cloud_firestore\.dart/d' lib/features/auth/presentation/screens/otp_verification_screen.dart

# Fix 6: Staff model phoneNumber → phone
echo "6️⃣  Fixing Staff model field names..."
sed -i 's/staff!\.phoneNumber/staff!.phone/g' lib/features/home/presentation/widgets/staff_info_card.dart
sed -i 's/staff\.phoneNumber/staff.phone/g' lib/features/home/presentation/widgets/staff_info_card.dart

echo ""
echo "✅ Basic fixes applied! Now applying complex fixes..."
echo ""

