import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';

part 'lead_model.freezed.dart';
part 'lead_model.g.dart';

@freezed
class LeadModel with _$LeadModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory LeadModel({
    num? leadId,
    num? uploadedBy,
    String? title,
    String? description,
    String? propertyType,
    String? rentalType,
    num? area,
    num? price,
    String? city,
    String? district,
    String? ward,
    String? street,
    String? requirements,
    num? numBedrooms,
    num? numBathrooms,
    String? houseDirection,
    String? balconyDirection,
    String? furnishing,
    num? frontWidth,
    num? entranceWidth,
    String? status,
    num? reviewedBy,
    String? reviewNote,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic isDesired,
    num? postId,
    String? code,
    String? legalStatus,
    String? legalDocuments,
  }) = _LeadModel;

  factory LeadModel.fromJson(Map<String, dynamic> json) =>
      _$LeadModelFromJson(json);
}

extension LeadModelExts on LeadModel {
  LeadEntity get toEntity => LeadEntity(
        leadId: leadId,
        uploadedBy: uploadedBy,
        title: title,
        description: description,
        propertyType: propertyType,
        rentalType: rentalType,
        area: area,
        price: price,
        city: city,
        district: district,
        ward: ward,
        street: street,
        requirements: requirements,
        numBedrooms: numBedrooms,
        numBathrooms: numBathrooms,
        houseDirection: houseDirection,
        balconyDirection: balconyDirection,
        furnishing: furnishing,
        frontWidth: frontWidth,
        entranceWidth: entranceWidth,
        status: status,
        reviewNote: reviewNote,
        reviewedBy: reviewedBy,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isDesired: isDesired,
        code: code,
        legalStatus: legalStatus,
        legalDocuments: legalDocuments,
      );
}
