import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_king/core/constants/enum.dart';
import 'package:insta_king/data/services/bill_services.dart';
import 'package:insta_king/data/services/error_service.dart';
import 'package:insta_king/data/services/get_bill_services.dart';
import 'package:insta_king/presentation/controllers/base_controller.dart';
import 'package:insta_king/presentation/model/get_cable_decoder_model.dart';
import 'package:insta_king/presentation/model/get_cable_plans.dart';

final instaCableController =
    ChangeNotifierProvider<CableController>((ref) => CableController());

class CableController extends BaseChangeNotifier {
  final GetBills getBills = GetBills();
  final PayBills payBills = PayBills();
  late GetCableDecoderModel getCableDecoderModel = GetCableDecoderModel();
  late GetCablePlanModel getCablePlanModel = GetCablePlanModel();

  void disposeCable() {
    getCableDecoderModel.data = [];
    getCablePlanModel.data = [];
  }

  Future<void> toGetCableDecoderPlans() async {
    if (getCableDecoderModel.data != null) return;

    try {
      debugPrint('To Get Cable Decoder Plans');
      final res = await getBills.getCableDecoders();

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        getCableDecoderModel =
            GetCableDecoderModel.fromJson(res.data.toString());
      } else {
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      ErrorService.handleErrors(e);
    } catch (e) {
      ErrorService.handleErrors(e);
    }
  }

  Future<void> toGetCablePlans(cableID) async {
    if (getCablePlanModel.data != null) return;

    try {
      debugPrint('To Get Cable Plans');
      final res = await getBills.getCablePlans(cableID);

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        getCablePlanModel = GetCablePlanModel.fromJson(res.data.toString());
      } else {
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      ErrorService.handleErrors(e);
    } catch (e) {
      ErrorService.handleErrors(e);
    }
  }

  Future<bool> tovalidateUserCableEligibiity(
    cableID,
    number,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To validate cable ligibility');
      final res = await payBills.cableValidation(cableID, number);

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.error;
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }

  Future<bool> toPurchaseCable(
    cablePlanID,
    number,
    cable,
    customerName,
  ) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('To Purchase Cable');
      final res = await payBills.cablePurchase(
        cablePlanID,
        number,
        cable,
        customerName,
      );

      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer ${res.data}");
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.error;
        debugPrint('${res.statusMessage}');
        debugPrint('${res.statusCode}');
        debugPrint(res.toString());
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
