// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dio/dio.dart';

class CustomException implements Exception {
  CustomException._(this.error, this.message);

  final CustomError error;
  final String message;

  @override
  String toString() => "message : $error";
}

class ExceptionHandler {
  static bool checkMessage(dynamic data, String equalTo) {
    try {
      if (data != null &&
          data["message"] != null &&
          data["message"]["message"] == equalTo) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  factory ExceptionHandler(dynamic error) {
    switch (error.runtimeType) {
      case NoSuchMethodError:
        error as NoSuchMethodError;
        throw CustomException._(CustomError.formatException, error.toString());
      case HandshakeException:
        error as HandshakeException;
        throw CustomException._(CustomError.unauthorized, error.toString());
      case FormatException:
        error as FormatException;
        throw CustomException._(CustomError.formatException, error.toString());
      case TypeError:
        error as TypeError;
        throw CustomException._(CustomError.formatException, error.toString());
      case DioError:
        error as DioError;
        if (error.type == DioErrorType.connectionTimeout ||
            error.type == DioErrorType.receiveTimeout ||
            error.type == DioErrorType.sendTimeout ||
            error.type == DioErrorType.cancel ||
            error.message == null ||
            (error.message!.contains("SocketException"))) {
          throw CustomException._(CustomError.noInternet, error.toString());
        } else {
          if (error.response != null) {
            if (error.response!.statusCode == 409) {
              if (error.response!.statusMessage == "Conflict") {
                throw CustomException._(
                    CustomError.noParamedic, error.toString());
              } else if (error.response!.statusMessage ==
                  "Paramedic not found") {
                throw CustomException._(
                    CustomError.noParamedic, error.toString());
              }
            }
            if (error.response!.statusCode == 401) {}
            if (error.response!.statusCode == 403) {
              throw CustomException._(CustomError.conflict, error.toString());
            }
            if (error.response!.statusCode == 404) {
              if (checkMessage(error.response!.data, "code not correct")) {
                throw CustomException._(CustomError.conflict, error.toString());
              }
            }
            if (error.response!.statusCode == 405) {
              if (error.response!.data == "Method Not Allowed") {
                throw CustomException._(
                    CustomError.processNotAvailable, error.toString());
              }
            }
          } else {
            throw CustomException._(CustomError.unKnown, error.toString());
          }
        }
        throw CustomException._(CustomError.unKnown, error.toString());
      case SocketException:
        error as SocketException;
        throw CustomException._(CustomError.noInternet, error.toString());
      case HttpException:
        error as HttpException;
        throw CustomException._(CustomError.noInternet, error.toString());
      default:
        throw CustomException._(CustomError.unKnown, error.toString());
    }
  }
}

enum CustomError {
  noInternet,
  conflict,
  unKnown,
  wrongCode,
  noParamedic,
  alreadyExists,
  notFound,
  formatException,
  badRequest,
  unauthorized,
  processNotAvailable,
}
