import 'dart:developer';

import 'package:chalet_spot/core/api/api_consumer.dart';
import 'package:chalet_spot/core/api/end_points.dart';
import 'package:chalet_spot/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/add_chalet.dart';

abstract class AddChaletDto {
  Future<Either<Failures, String>> addChalet(AddChalet chalet);
}

class AddChaletRemoteDto extends AddChaletDto {
  ApiConsumer api;

  AddChaletRemoteDto(this.api);

  @override
  Future<Either<Failures, String>> addChalet(AddChalet chalet) async {
    try {
      // Create a Dio instance
      final Dio dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      print(token);
      // Perform the POST request
      final response = await dio.post(
        'https://chaletspot.vercel.app/owner/chalets/new',
        data: chalet.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
            'token': token, // Include the token in the headers
          },
        ),
      );

      // Log the response for debugging
      log('Response: ${response.data}');

      // Check the status code and handle the response accordingly
      if (response.statusCode == 200) {
        // Extract the message from the response
        final message = response.data['msg'];
        return Right(message);
      } else {
        // Handle non-200 responses
        return Left(ServerFailures(
            'Unexpected response status: ${response.statusCode}'));
      }
    } catch (e) {
      // Log the error for debugging
      log('Error: $e');

      // Return a failure with the error message
      return Left(ServerFailures(e.toString()));
    }
  }
}
