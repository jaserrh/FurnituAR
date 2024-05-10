import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';

class ApiConsumer {
  Future<Uint8List> removeImageBackgroundApi(String imagePath) async {
    //request
    var requestApi = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));

    //which image file to send - define
    requestApi.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));

    //api header - communicate with help of apiKey
    requestApi.headers.addAll({"X-API-Key": "pGYXdFM3t2hWfqvMwzUpC3KD"});

    //send request and receive response
    final responseFromApi = await requestApi.send();

    if (responseFromApi.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(responseFromApi);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception(
          "Error Occured:: " + responseFromApi.statusCode.toString());
    }
  }

  Future<String> sendImageAndGet3DObject(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("http://192.168.1.15:5000/process_image"),
    );

    // Attach image bytes as a file
    request.files.add(
      http.MultipartFile.fromBytes('image', imageBytes, filename: 'image.jpg'),
    );

    // Send request
    var response = await request.send();

    // Receive response
    if (response.statusCode == 200) {
      // Get the response body as a string
      final String responseBody = await response.stream.bytesToString();

      // Parse the JSON response to extract the download URL
      final Map<String, dynamic> json = jsonDecode(responseBody);
      final String downloadUrl = json['download_url'];

      // Return the download URL
      return downloadUrl;²
    } else {
      // Handle error
      print('Error: ${response.reasonPhrase}');
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<String> sendImageAndGetObjFile(File imageFile) async {
    // Define the server URL
    final String serverUrl = 'http://192.168.1.15:5000/process_image';

    try {
      // Create a multipart request
      final request = http.MultipartRequest('POST', Uri.parse(serverUrl));

      // Add the image file to the request
      request.files.add(http.MultipartFile(
          'image', imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
          filename: 'image.jpg', contentType: MediaType('image', 'jpeg')));

      // Send the request
      final response = await request.send();

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Get the response body as a string
        final String responseBody = await response.stream.bytesToString();

        // Parse the JSON response to extract the download URL
        final Map<String, dynamic> json = jsonDecode(responseBody);
        final String downloadUrl = json['download_url'];

        // Return the download URL
        return downloadUrl;
      } else {
        // Handle error
        print('Error: ${response.reasonPhrase}');
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<String> save3DObjectToStorage(Uint8List objectBytes) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child('3DObjects').child('${Uuid().v1()}.obj');
    UploadTask uploadTask = ref.putData(objectBytes);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
