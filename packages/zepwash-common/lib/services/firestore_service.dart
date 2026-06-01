import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/exceptions.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Generic CRUD operations

  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } catch (e) {
      throw FirestoreException('Failed to get document: $e');
    }
  }

  Stream<DocumentSnapshot> streamDocument(String collection, String docId) {
    return _firestore.collection(collection).doc(docId).snapshots();
  }

  Future<QuerySnapshot> getCollection(
    String collection, {
    List<QueryFilter>? filters,
    List<OrderBy>? orderBy,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(collection);

      if (filters != null) {
        for (final filter in filters) {
          query = query.where(filter.field,
              isEqualTo: filter.isEqualTo,
              isGreaterThan: filter.isGreaterThan,
              isLessThan: filter.isLessThan);
        }
      }

      if (orderBy != null) {
        for (final order in orderBy) {
          query = query.orderBy(order.field, descending: order.descending);
        }
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      return await query.get();
    } catch (e) {
      throw FirestoreException('Failed to get collection: $e');
    }
  }

  Stream<QuerySnapshot> streamCollection(
    String collection, {
    List<QueryFilter>? filters,
    List<OrderBy>? orderBy,
    int? limit,
  }) {
    Query query = _firestore.collection(collection);

    if (filters != null) {
      for (final filter in filters) {
        query = query.where(filter.field,
            isEqualTo: filter.isEqualTo,
            isGreaterThan: filter.isGreaterThan,
            isLessThan: filter.isLessThan);
      }
    }

    if (orderBy != null) {
      for (final order in orderBy) {
        query = query.orderBy(order.field, descending: order.descending);
      }
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots();
  }

  Future<DocumentReference> addDocument(
    String collection,
    Map<String, dynamic> data,
  ) async {
    try {
      return await _firestore.collection(collection).add(data);
    } catch (e) {
      throw FirestoreException('Failed to add document: $e');
    }
  }

  Future<void> setDocument(
    String collection,
    String docId,
    Map<String, dynamic> data, {
    bool merge = false,
  }) async {
    try {
      await _firestore
          .collection(collection)
          .doc(docId)
          .set(data, SetOptions(merge: merge));
    } catch (e) {
      throw FirestoreException('Failed to set document: $e');
    }
  }

  Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      throw FirestoreException('Failed to update document: $e');
    }
  }

  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      throw FirestoreException('Failed to delete document: $e');
    }
  }

  // Batch operations
  WriteBatch batch() => _firestore.batch();

  Future<void> commitBatch(WriteBatch batch) async {
    try {
      await batch.commit();
    } catch (e) {
      throw FirestoreException('Failed to commit batch: $e');
    }
  }
}

// Helper classes for query building
class QueryFilter {
  final String field;
  final dynamic isEqualTo;
  final dynamic isGreaterThan;
  final dynamic isLessThan;

  QueryFilter(
    this.field, {
    this.isEqualTo,
    this.isGreaterThan,
    this.isLessThan,
  });
}

class OrderBy {
  final String field;
  final bool descending;

  OrderBy(this.field, {this.descending = false});
}
