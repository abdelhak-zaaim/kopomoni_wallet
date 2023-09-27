
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/model/websitelink_models.dart';
import 'package:six_cash/data/repository/websitelink_repo.dart';
import 'package:get/get.dart';

class WebsiteLinkController extends GetxController implements GetxService{
  final WebsiteLinkRepo websiteLinkRepo;
  WebsiteLinkController({required this.websiteLinkRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<WebsiteLinkModel>? _websiteList;
  List<WebsiteLinkModel>? get websiteList => _websiteList;

  Future getWebsiteList(bool reload , {bool isUpdate = true})async{
    if(_websiteList == null || reload) {
      _websiteList = null;
      _isLoading = true;
      if(isUpdate){
        update();
      }
    }
    if(_websiteList == null ) {
      _websiteList = [];
      Response response = await websiteLinkRepo.getWebsiteListApi();
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _websiteList = [];
        response.body.forEach((website) {_websiteList!.add(WebsiteLinkModel.fromJson(website));});
      }else{
        _websiteList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}