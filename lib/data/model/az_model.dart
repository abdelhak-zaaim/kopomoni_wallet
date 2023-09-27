import 'package:azlistview/azlistview.dart';
import 'package:flutter_contacts/contact.dart';

class AzItem extends ISuspensionBean{
  final Contact? contact;
  final String tag;
  AzItem({required this.contact, required this.tag});

  @override
  String getSuspensionTag()=> tag;
}