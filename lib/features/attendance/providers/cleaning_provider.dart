import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zepwash_common/models/cleaning.dart';
import '../../../core/providers/firestore_provider.dart';
import '../../../features/home/providers/customer_provider.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final cleaningProvider = StreamProvider.autoDispose<Cleaning?>((ref) {
  final customerId = ref.watch(
    selectedCustomerProvider.select((c) => c?.id),
  );
  if (customerId == null) return Stream.value(null);

  final selectedDate = ref.watch(selectedDateProvider);
  final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
  final firestore = ref.watch(firestoreProvider);

  return firestore
      .collection('cleanings')
      .where('customerId', isEqualTo: customerId)
      .where('date', isEqualTo: dateStr)
      .snapshots()
      .map((snapshot) {
    if (snapshot.docs.isEmpty) return null;
    return Cleaning.fromFirestore(snapshot.docs.first);
  });
});
