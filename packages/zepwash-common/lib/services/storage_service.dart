import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/exceptions.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  // Upload file with progress tracking
  Future<String> uploadFile(
    Uint8List bytes,
    String path, {
    Function(double progress)? onProgress,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putData(bytes);

      if (onProgress != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        });
      }

      await uploadTask;
      return await ref.getDownloadURL();
    } catch (e) {
      throw StorageException('Failed to upload file: $e');
    }
  }

  // Delete file
  Future<void> deleteFile(String path) async {
    try {
      await _storage.ref().child(path).delete();
    } catch (e) {
      throw StorageException('Failed to delete file: $e');
    }
  }

  // Get download URL
  Future<String> getDownloadURL(String path) async {
    try {
      return await _storage.ref().child(path).getDownloadURL();
    } catch (e) {
      throw StorageException('Failed to get download URL: $e');
    }
  }

  // Upload complaint image
  Future<String> uploadComplaintImage(
    String customerId,
    Uint8List imageBytes,
  ) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = 'complaints/$customerId/$timestamp.jpg';
    return await uploadFile(imageBytes, path);
  }

  // Upload cleaning proof photo
  Future<String> uploadCleaningPhoto(
    String staffId,
    String cleaningId,
    Uint8List photoBytes, {
    Function(double progress)? onProgress,
  }) async {
    final path = 'cleanings/$staffId/$cleaningId.jpg';
    return await uploadFile(photoBytes, path, onProgress: onProgress);
  }
}
