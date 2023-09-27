
class EditProfileBody {
  String? fName;
  String? lName;
  String? email;
  String? gender;
  String? occupation;

  EditProfileBody({required this.fName,required this.lName, this.email='',required this.gender,required this.occupation});

  EditProfileBody.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    gender = json['gender'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['email'] = email;
    data['gender'] = gender;
    data['occupation'] = occupation;
    return data;
  }
}