class RequestedMoneyModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<RequestedMoney>? requestedMoney;

  RequestedMoneyModel(
      {this.totalSize, this.limit, this.offset, this.requestedMoney});

  RequestedMoneyModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['requested_money'] != null) {
      requestedMoney = <RequestedMoney>[];
      json['requested_money'].forEach((v) {
        requestedMoney!.add(RequestedMoney.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (requestedMoney != null) {
      data['requested_money'] =
          requestedMoney!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestedMoney {
  int? id;
  Sender? sender;
  Receiver? receiver;
  String? type;
  double? amount;
  String? note;
  String? createdAt;

  RequestedMoney(
      {this.id,
        this.sender,
        this.receiver,
        this.type,
        this.amount,
        this.note,
        this.createdAt});

  RequestedMoney.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender =
    json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver =
    json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
    // json['sender'] != null ? new Sender.fromJson(json['sender']) : 'User Unavailable';
    // receiver =
    // json['receiver'] != null ? new Receiver.fromJson(json['receiver']) : 'User Unavailable';
    type = json['type'];
    amount = json['amount'].toDouble();
    note = json['note'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (sender != null) {
      data['receiver'] = sender!.toJson();
    }
    data['type'] = type;
    data['amount'] = amount;
    data['note'] = note;
    data['created_at'] = createdAt;
    return data;
  }
}

class Sender {
  String? phone;
  String? name;

  Sender({this.phone, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    // phone = json['phone'] != null ? json['phone'] : 'User Unavailable';
    // name = json['name'] != null ? json['phone'] : 'User Unavailable';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['name'] = name;
    return data;
  }
}
class Receiver {
  String? phone;
  String? name;

  Receiver({this.phone, this.name});

  Receiver.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    // phone = json['phone'] != null ? json['phone'] : 'User Unavailable';
    // name = json['name'] != null ? json['phone'] : 'User Unavailable';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['name'] = name;
    return data;
  }
}
