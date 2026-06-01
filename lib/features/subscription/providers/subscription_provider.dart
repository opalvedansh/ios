import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zepwash_common/zepwash_common.dart';

/// Provider to fetch subscription data by ID
final subscriptionStreamProvider = StreamProvider.family<Subscription?, String>((ref, subscriptionId) {
  return FirebaseFirestore.instance
      .collection('subscriptions')
      .doc(subscriptionId)
      .snapshots()
      .map((doc) {
    if (!doc.exists) return null;
    return Subscription.fromFirestore(doc);
  });
});
