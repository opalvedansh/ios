import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../core/providers/firestore_provider.dart';
import '../../../core/providers/storage_provider.dart';
import '../../../features/home/providers/customer_provider.dart';

/// Provider for list of complaints for the selected customer profile
final customerComplaintsProvider = StreamProvider<List<Complaint>>((ref) {
  final customerId = ref.watch(
    selectedCustomerProvider.select((c) => c?.id),
  );
  if (customerId == null) {
    return Stream.value([]);
  }

  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService
      .streamCollection(
        'complaints',
        filters: [QueryFilter('customerId', isEqualTo: customerId)],
        orderBy: [OrderBy('createdAt', descending: true)],
      )
      .map((snapshot) =>
          snapshot.docs.map((doc) => Complaint.fromFirestore(doc)).toList());
});

/// Provider for complaint operations
final complaintControllerProvider = Provider((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final storageService = ref.watch(storageServiceProvider);
  final customerId = ref.watch(
    selectedCustomerProvider.select((c) => c?.id),
  );

  return ComplaintController(
    firestoreService: firestoreService,
    storageService: storageService,
    customerId: customerId,
  );
});

class ComplaintController {
  final FirestoreService _firestoreService;
  final StorageService _storageService;
  final String? _customerId;

  ComplaintController({
    required FirestoreService firestoreService,
    required StorageService storageService,
    required String? customerId,
  })  : _firestoreService = firestoreService,
        _storageService = storageService,
        _customerId = customerId;

  Future<void> createComplaint({
    required String category,
    required String description,
    Uint8List? imageBytes,
  }) async {
    if (_customerId == null) {
      throw Exception('No active vehicle profile selected');
    }

    String? imageUrl;
    if (imageBytes != null) {
      imageUrl = await _storageService.uploadComplaintImage(
        _customerId!,
        imageBytes,
      );
    }

    final complaintData = {
      'customerId': _customerId,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'status': 'open',
      'createdAt': DateTime.now(),
    };

    await _firestoreService.addDocument('complaints', complaintData);
  }
}
