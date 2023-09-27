import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/repository/kyc_verify_repo.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import '../data/api/api_client.dart';

class KycVerifyController extends GetxController implements GetxService{
  final KycVerifyRepo kycVerifyRepo;
  KycVerifyController({required this.kycVerifyRepo});
  List <XFile>? _imageFile;
  List <XFile>_identityImage = [];
  List<XFile> get identityImage => _identityImage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<String> _dropList = [
    'select_identity_type'.tr,
    'passport'.tr,
    'driving_licence'.tr,
    'nid'.tr,
    'trade_license'.tr,
  ];
  List<String> get dropList => _dropList;

  String _dropDownSelectedValue = 'select_identity_type'.tr;
  String  get dropDownSelectedValue => _dropDownSelectedValue;

  void dropDownChange(String value) {
    _dropDownSelectedValue = value;
    update();
  }
  void initialSelect() {
    _dropDownSelectedValue = 'select_identity_type'.tr;
    _identityImage = [];
    _isLoading = false;
  }

  void pickImage(bool isRemove) async {
    final ImagePicker picker = ImagePicker();
    if(isRemove) {
      _imageFile = [];
    }else {
      _imageFile = await picker.pickMultiImage(imageQuality: 30);
      if (_imageFile != null) {
        _identityImage.addAll(_imageFile!);
      }
    }
    update();
  }
  void removeImage(int index){
    _identityImage.removeAt(index);
    update();
  }
  List<MultipartBody>? _multipartBody;

  Future<void> kycVerify(String idNumber) async{
    Map<String, String> field = {
      'identification_number': idNumber,
      'identification_type': _dropDownSelectedValue == 'passport'.tr ? 'passport'
          : _dropDownSelectedValue == 'driving_licence'.tr ? 'driving_licence'
          : _dropDownSelectedValue == 'nid'.tr ? 'nid'
          : _dropDownSelectedValue == 'trade_license'.tr ? 'trade_license' : 'select_identity_type',
      '_method': 'put'
    };
    _multipartBody = _identityImage.map((image) => MultipartBody('identification_image[]', File(image.path))).toList();
    _isLoading = true;
    update();
    Response response = await kycVerifyRepo.kycVerifyApi(field, _multipartBody);
    if(response.body['response_code'] == 'default_update_200') {
      Get.back();
      showCustomSnackBar(response.body['message'], isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

}