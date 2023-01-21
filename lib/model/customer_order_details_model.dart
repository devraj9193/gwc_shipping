// To parse this JSON data, do
//
//     final customerOrderDetails = customerOrderDetailsFromJson(jsonString);

import 'dart:convert';

CustomerOrderDetails customerOrderDetailsFromJson(String str) =>
    CustomerOrderDetails.fromJson(json.decode(str));

String customerOrderDetailsToJson(CustomerOrderDetails data) =>
    json.encode(data.toJson());

class CustomerOrderDetails {
  CustomerOrderDetails({
    this.status,
    this.errorCode,
    this.data,
  });

  int? status;
  int? errorCode;
  Data? data;

  factory CustomerOrderDetails.fromJson(Map<String, dynamic> json) =>
      CustomerOrderDetails(
        status: json["status"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.shippingProductList,
  });

  List<GetShoppingListElement>? shippingProductList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shippingProductList: List<GetShoppingListElement>.from(
            json["shipping_product_list"]
                .map((x) => GetShoppingListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shipping_product_list":
            List<dynamic>.from(shippingProductList!.map((x) => x.toJson())),
      };
}

class GetShoppingListElement {
  GetShoppingListElement({
    this.id,
    this.teamPatientId,
    this.itemId,
    this.totalWeight,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.itemWeight,
    this.mealItem,
  });

  int? id;
  String? teamPatientId;
  String? itemId;
  String? totalWeight;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  String? itemWeight;
  MealItem? mealItem;

  factory GetShoppingListElement.fromJson(Map<String, dynamic> json) =>
      GetShoppingListElement(
        id: json["id"],
        teamPatientId: json["team_patient_id"].toString(),
        itemId: json["item_id"].toString(),
        totalWeight: json["total_weight"].toString(),
        addedBy: json["added_by"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        itemWeight: json["item_weight"].toString(),
        mealItem: MealItem.fromJson(json["meal_item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "team_patient_id": teamPatientId,
        "item_id": itemId,
        "total_weight": totalWeight,
        "added_by": addedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "item_weight": itemWeight,
        "meal_item": mealItem?.toJson(),
      };
}

class MealItem {
  MealItem({
    this.id,
    this.name,
    this.mealTimingId,
    this.recipeId,
    this.programId,
    this.inCookingKit,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.mealItemWeight,
  });

  int? id;
  String? name;
  String? mealTimingId;
  String? recipeId;
  String? programId;
  String? inCookingKit;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  List<MealItemWeight>? mealItemWeight;

  factory MealItem.fromJson(Map<String, dynamic> json) => MealItem(
        id: json["id"],
        name: json["name"].toString(),
        mealTimingId: json["meal_timing_id"].toString(),
        recipeId: json["recipe_id"].toString(),
        programId: json["program_id"].toString(),
        inCookingKit: json["in_cooking_kit"].toString(),
        addedBy: json["added_by"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        mealItemWeight: List<MealItemWeight>.from(
            json["meal_item_weight"].map((x) => MealItemWeight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "meal_timing_id": mealTimingId,
        "recipe_id": recipeId,
        "program_id": programId,
        "in_cooking_kit": inCookingKit,
        "added_by": addedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "meal_item_weight":
            List<dynamic>.from(mealItemWeight!.map((x) => x.toJson())),
      };
}

class MealItemWeight {
  MealItemWeight({
    this.id,
    this.mealPlanItemId,
    this.weight,
    this.weightTypeId,
    this.createdAt,
    this.updatedAt,
    this.weightType,
  });

  int? id;
  String? mealPlanItemId;
  String? weight;
  String? weightTypeId;
  String? createdAt;
  String? updatedAt;
  WeightType? weightType;

  factory MealItemWeight.fromJson(Map<String, dynamic> json) => MealItemWeight(
        id: json["id"] ?? "",
        mealPlanItemId: json["meal_plan_item_id"] ?? "",
        weight: json["weight"] ?? "",
        weightTypeId: json["weight_type_id"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        weightType: WeightType.fromJson(json["weight_type"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meal_plan_item_id": mealPlanItemId,
        "weight": weight,
        "weight_type_id": weightTypeId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "weight_type": weightType?.toJson(),
      };
}

class WeightType {
  WeightType({
    this.id,
    this.unit,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? unit;
  String? createdAt;
  String? updatedAt;

  factory WeightType.fromJson(Map<String, dynamic> json) => WeightType(
        id: json["id"] ?? "",
        unit: json["unit"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
