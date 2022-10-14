import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  UploadTask? uploadTask;

  // uploading image to firebase storage
  Future<String> uploade(String id, File file) async {
    final String path = '$id/images/profile';
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    return await snapshot.ref.getDownloadURL();
  }
}
