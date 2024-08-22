// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
// class UploadImage {
//   File? _updateImage;
//   String? imageUrl;
//
//   void pickImage() async {
//     var image = await ImagePicker().pickImage(source: ImageSource.camera);
//
//     if (image != null) {
//       _updateImage = File(image.path);
//
//       uploadImageToFirebaseStorage();
//     }
//   }
//
//   Future<void> getImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       _updateImage = File(pickedFile.path);
//
//       uploadImageToFirebaseStorage();
//     }
//   }
//
//   Future<void> uploadImageToFirebaseStorage() async {
//     try {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       firebase_storage.Reference firebaseStorageRef =
//           firebase_storage.FirebaseStorage.instance.ref().child(fileName);
//       firebase_storage.UploadTask uploadTask =
//           firebaseStorageRef.putFile(_updateImage!);
//
//       await uploadTask.whenComplete(() async {
//         imageUrl = await firebaseStorageRef.getDownloadURL();
//
//         print("Image uploaded to Firebase Storage: $imageUrl");
//       });
//     } catch (error) {
//       print("Error uploading image to Firebase Storage: $error");
//       // Handle error as needed
//     }
//   }
// }
