
class PaymentModel {
  String message;
  bool success;
  List<PaymentListModel> data;

  PaymentModel({
    required this.message,
    required this.success,
    required this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    message: json["message"],
    success: json["success"],
    data: List<PaymentListModel>.from(json["data"].map((x) => PaymentListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PaymentListModel {
  int id;
  String packageName;
  String durationUnit;
  int durationValue;
  double price;

  PaymentListModel({
    required this.id,
    required this.packageName,
    required this.durationUnit,
    required this.durationValue,
    required this.price,
  });

  factory PaymentListModel.fromJson(Map<String, dynamic> json) => PaymentListModel(
    id: json["id"],
    packageName: json["packageName"],
    durationUnit: json["durationUnit"],
    durationValue: json["durationValue"],
    price: json["price"].toDouble(), // Ensure price is cast to double
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "packageName": packageName,
    "durationUnit": durationUnit,
    "durationValue": durationValue,
    "price": price,
  };
}

