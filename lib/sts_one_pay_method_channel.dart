import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sts_one_pay/models/sts_one_pay.dart';

import 'models/error_sts_one_pay.dart';
import 'models/other_api.dart';
import 'models/payment_page_response.dart';
import 'sts_one_pay_platform_interface.dart';

class MethodChannelStsOnePay extends StsOnePayPlatform {
  final MethodChannel _channel =
      const MethodChannel('samples.flutter.dev/payment');

  @override
  Future<void> openPaymentPage(
    StsOnePay stsOnePay, {
    required Function(StsOnePayResponse result) onResultResponse,
  }) async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod(
          'paymentMethod',
          stsOnePay.toJson(),
        );
        _channel.setMethodCallHandler((call) async {
          if (call.method == 'getResult') {
            try {
              Map<String, dynamic> data = Map.castFrom(call.arguments['data']);
              String status = call.arguments['status'];
              if (status == 'success') {
                onResultResponse(StsOnePayResponse.fromJsonSuccess(data));
              } else {
                onResultResponse(StsOnePayResponse.fromJsonFailed(data));
              }
            } catch (e) {
              log(e.toString());
              throw Exception('Error in call arguments');
            }
          }
        });
      } else if (Platform.isIOS) {
        /// implement ios method
      } else {
        throw const ErrorStsOnePay(
          code: 2011,
          message: 'Platform Not supports',
        );
      }
    } on PlatformException catch (e) {
      throw ErrorStsOnePay(
        code: 2012,
        message: 'Platform Exception ${e.message}',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> refund(OtherAPI otherAPI) async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod(
          'refund',
          otherAPI.toJson(),
        );
      } else if (Platform.isIOS) {
        /// implement ios method
      } else {
        throw const ErrorStsOnePay(
          code: 2011,
          message: 'Platform Not supports',
        );
      }
    } on PlatformException catch (e) {
      throw ErrorStsOnePay(
        code: 2012,
        message: 'Platform Exception ${e.message}',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> completion(OtherAPI otherAPI) async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod(
          'completion',
          otherAPI.toJson(),
        );
      } else if (Platform.isIOS) {
        /// implement ios method
      } else {
        throw const ErrorStsOnePay(
          code: 2011,
          message: 'Platform Not supports',
        );
      }
    } on PlatformException catch (e) {
      throw ErrorStsOnePay(
        code: 2012,
        message: 'Platform Exception ${e.message}',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> inquiry(OtherAPI otherAPI) async {
    try {
      if (Platform.isAndroid) {
        await _channel.invokeMethod(
          'inquiry',
          otherAPI.toJson(),
        );
      } else if (Platform.isIOS) {
        /// implement ios method
      } else {
        throw const ErrorStsOnePay(
          code: 2011,
          message: 'Platform Not supports',
        );
      }
    } on PlatformException catch (e) {
      throw ErrorStsOnePay(
        code: 2012,
        message: 'Platform Exception ${e.message}',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
/*
                      log(e.toString());
                throw Exception('Error in call arguments');
       */
