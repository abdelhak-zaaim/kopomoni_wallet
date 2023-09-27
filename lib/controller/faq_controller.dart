import 'package:six_cash/data/model/response/faq_model.dart';
import 'package:six_cash/data/repository/faq_repo.dart';
import 'package:get/get.dart';

class FaqController extends GetxController implements GetxService {
  final FaqRepo faqrepo;
  FaqController({required this.faqrepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<HelpTopic>? _helpTopics;
  List<HelpTopic>? get helpTopics => _helpTopics;


  Future getFaqList() async{
    _isLoading = true;
    _helpTopics = [];
    Response response = await faqrepo.getFaqList();
    if(response.body != null && response.body != {} && response.statusCode == 200){
      _helpTopics =   FaqModel.fromJson(response.body).helpTopics;
      _isLoading = false;
      update();
    }
  }
}