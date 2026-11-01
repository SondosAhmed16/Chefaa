import 'dart:convert';

import 'package:collection/collection.dart';

import 'item.dart';
import 'status_history.dart';
import 'user_id.dart';

class Order {
  dynamic deliveryAddress;
  String? id;
  String? pharmacyId;
  UserId? userId;
  dynamic deliveryManId;
  dynamic prescriptionId;
  String? orderNumber;
  List<Item>? items;
  String? orderType;
  String? status;
  List<StatusHistory>? statusHistory;
  bool? pharmacyConfirmedCompletion;
  dynamic pharmacyConfirmedAt;
  bool? patientConfirmedCompletion;
  dynamic patientConfirmedAt;
  dynamic completedAt;
  String? paymentMethod;
  String? paymentStatus;
  int? subtotal;
  int? deliveryFee;
  int? discount;
  int? totalPrice;
  int? commissionRate;
  double? commissionAmount;
  double? pharmacyEarning;
  bool? commissionPaid;
  dynamic commissionPaidAt;
  dynamic commissionPaidInCycleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Order({
    this.deliveryAddress,
    this.id,
    this.pharmacyId,
    this.userId,
    this.deliveryManId,
    this.prescriptionId,
    this.orderNumber,
    this.items,
    this.orderType,
    this.status,
    this.statusHistory,
    this.pharmacyConfirmedCompletion,
    this.pharmacyConfirmedAt,
    this.patientConfirmedCompletion,
    this.patientConfirmedAt,
    this.completedAt,
    this.paymentMethod,
    this.paymentStatus,
    this.subtotal,
    this.deliveryFee,
    this.discount,
    this.totalPrice,
    this.commissionRate,
    this.commissionAmount,
    this.pharmacyEarning,
    this.commissionPaid,
    this.commissionPaidAt,
    this.commissionPaidInCycleId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Order(deliveryAddress: $deliveryAddress, id: $id, pharmacyId: $pharmacyId, userId: $userId, deliveryManId: $deliveryManId, prescriptionId: $prescriptionId, orderNumber: $orderNumber, items: $items, orderType: $orderType, status: $status, statusHistory: $statusHistory, pharmacyConfirmedCompletion: $pharmacyConfirmedCompletion, pharmacyConfirmedAt: $pharmacyConfirmedAt, patientConfirmedCompletion: $patientConfirmedCompletion, patientConfirmedAt: $patientConfirmedAt, completedAt: $completedAt, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, subtotal: $subtotal, deliveryFee: $deliveryFee, discount: $discount, totalPrice: $totalPrice, commissionRate: $commissionRate, commissionAmount: $commissionAmount, pharmacyEarning: $pharmacyEarning, commissionPaid: $commissionPaid, commissionPaidAt: $commissionPaidAt, commissionPaidInCycleId: $commissionPaidInCycleId, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Order.fromMap(Map<String, dynamic> data) => Order(
    deliveryAddress: data['deliveryAddress'] as dynamic,
    id: data['_id'] as String?,
    pharmacyId: data['pharmacyId'] as String?,
    userId: data['userId'] == null
        ? null
        : UserId.fromMap(data['userId'] as Map<String, dynamic>),
    deliveryManId: data['deliveryManId'] as dynamic,
    prescriptionId: data['prescriptionId'] as dynamic,
    orderNumber: data['orderNumber'] as String?,
    items: (data['items'] as List<dynamic>?)
        ?.map((e) => Item.fromMap(e as Map<String, dynamic>))
        .toList(),
    orderType: data['orderType'] as String?,
    status: data['status'] as String?,
    statusHistory: (data['statusHistory'] as List<dynamic>?)
        ?.map((e) => StatusHistory.fromMap(e as Map<String, dynamic>))
        .toList(),
    pharmacyConfirmedCompletion: data['pharmacyConfirmedCompletion'] as bool?,
    pharmacyConfirmedAt: data['pharmacyConfirmedAt'] as dynamic,
    patientConfirmedCompletion: data['patientConfirmedCompletion'] as bool?,
    patientConfirmedAt: data['patientConfirmedAt'] as dynamic,
    completedAt: data['completedAt'] as dynamic,
    paymentMethod: data['paymentMethod'] as String?,
    paymentStatus: data['paymentStatus'] as String?,
    subtotal: data['subtotal'] as int?,
    deliveryFee: data['deliveryFee'] as int?,
    discount: data['discount'] as int?,
    totalPrice: data['totalPrice'] as int?,
    commissionRate: data['commissionRate'] as int?,
    commissionAmount: (data['commissionAmount'] as num?)?.toDouble(),
    pharmacyEarning: (data['pharmacyEarning'] as num?)?.toDouble(),
    commissionPaid: data['commissionPaid'] as bool?,
    commissionPaidAt: data['commissionPaidAt'] as dynamic,
    commissionPaidInCycleId: data['commissionPaidInCycleId'] as dynamic,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'deliveryAddress': deliveryAddress,
    '_id': id,
    'pharmacyId': pharmacyId,
    'userId': userId?.toMap(),
    'deliveryManId': deliveryManId,
    'prescriptionId': prescriptionId,
    'orderNumber': orderNumber,
    'items': items?.map((e) => e.toMap()).toList(),
    'orderType': orderType,
    'status': status,
    'statusHistory': statusHistory?.map((e) => e.toMap()).toList(),
    'pharmacyConfirmedCompletion': pharmacyConfirmedCompletion,
    'pharmacyConfirmedAt': pharmacyConfirmedAt,
    'patientConfirmedCompletion': patientConfirmedCompletion,
    'patientConfirmedAt': patientConfirmedAt,
    'completedAt': completedAt,
    'paymentMethod': paymentMethod,
    'paymentStatus': paymentStatus,
    'subtotal': subtotal,
    'deliveryFee': deliveryFee,
    'discount': discount,
    'totalPrice': totalPrice,
    'commissionRate': commissionRate,
    'commissionAmount': commissionAmount,
    'pharmacyEarning': pharmacyEarning,
    'commissionPaid': commissionPaid,
    'commissionPaidAt': commissionPaidAt,
    'commissionPaidInCycleId': commissionPaidInCycleId,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Order].
  factory Order.fromJson(String data) {
    return Order.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Order] to a JSON string.
  String toJson() => json.encode(toMap());

  Order copyWith({
    dynamic deliveryAddress,
    String? id,
    String? pharmacyId,
    UserId? userId,
    dynamic deliveryManId,
    dynamic prescriptionId,
    String? orderNumber,
    List<Item>? items,
    String? orderType,
    String? status,
    List<StatusHistory>? statusHistory,
    bool? pharmacyConfirmedCompletion,
    dynamic pharmacyConfirmedAt,
    bool? patientConfirmedCompletion,
    dynamic patientConfirmedAt,
    dynamic completedAt,
    String? paymentMethod,
    String? paymentStatus,
    int? subtotal,
    int? deliveryFee,
    int? discount,
    int? totalPrice,
    int? commissionRate,
    double? commissionAmount,
    double? pharmacyEarning,
    bool? commissionPaid,
    dynamic commissionPaidAt,
    dynamic commissionPaidInCycleId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Order(
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      id: id ?? this.id,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      userId: userId ?? this.userId,
      deliveryManId: deliveryManId ?? this.deliveryManId,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      orderNumber: orderNumber ?? this.orderNumber,
      items: items ?? this.items,
      orderType: orderType ?? this.orderType,
      status: status ?? this.status,
      statusHistory: statusHistory ?? this.statusHistory,
      pharmacyConfirmedCompletion:
          pharmacyConfirmedCompletion ?? this.pharmacyConfirmedCompletion,
      pharmacyConfirmedAt: pharmacyConfirmedAt ?? this.pharmacyConfirmedAt,
      patientConfirmedCompletion:
          patientConfirmedCompletion ?? this.patientConfirmedCompletion,
      patientConfirmedAt: patientConfirmedAt ?? this.patientConfirmedAt,
      completedAt: completedAt ?? this.completedAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      commissionRate: commissionRate ?? this.commissionRate,
      commissionAmount: commissionAmount ?? this.commissionAmount,
      pharmacyEarning: pharmacyEarning ?? this.pharmacyEarning,
      commissionPaid: commissionPaid ?? this.commissionPaid,
      commissionPaidAt: commissionPaidAt ?? this.commissionPaidAt,
      commissionPaidInCycleId:
          commissionPaidInCycleId ?? this.commissionPaidInCycleId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Order) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      deliveryAddress.hashCode ^
      id.hashCode ^
      pharmacyId.hashCode ^
      userId.hashCode ^
      deliveryManId.hashCode ^
      prescriptionId.hashCode ^
      orderNumber.hashCode ^
      items.hashCode ^
      orderType.hashCode ^
      status.hashCode ^
      statusHistory.hashCode ^
      pharmacyConfirmedCompletion.hashCode ^
      pharmacyConfirmedAt.hashCode ^
      patientConfirmedCompletion.hashCode ^
      patientConfirmedAt.hashCode ^
      completedAt.hashCode ^
      paymentMethod.hashCode ^
      paymentStatus.hashCode ^
      subtotal.hashCode ^
      deliveryFee.hashCode ^
      discount.hashCode ^
      totalPrice.hashCode ^
      commissionRate.hashCode ^
      commissionAmount.hashCode ^
      pharmacyEarning.hashCode ^
      commissionPaid.hashCode ^
      commissionPaidAt.hashCode ^
      commissionPaidInCycleId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
