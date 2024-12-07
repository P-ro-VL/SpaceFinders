import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/entity/lead_entity.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class CreateLeadUseCase
    extends UseCase<Either<FailureEntity, LeadEntity>, CreateLeadParams> {
  final LeadRepository repository;

  CreateLeadUseCase(this.repository);

  @override
  Future<Either<FailureEntity, LeadEntity>> call(
      CreateLeadParams params) async {
    return await repository.createLead(params);
  }
}

class CreateLeadParams {
  final num? uploadedBy;
  final String? title;
  final String? description;
  final String? propertyType;
  final String? rentalType;
  final num? area;
  final num? price;
  final String? city;
  final String? district;
  final String? ward;
  final String? street;
  final String? requirements;
  final num? numBedrooms;
  final num? numBathrooms;
  final String? houseDirection;
  final String? balconyDirection;
  final String? furnishing;
  final num? frontWidth;
  final num? entranceWidth;
  final String? status;
  final num? reviewedBy;
  final String? reviewNote;
  final dynamic isDesired;
  final String? legalStatus;
  final String? code;

  CreateLeadParams({
    this.uploadedBy,
    this.title,
    this.description,
    this.propertyType,
    this.rentalType,
    this.area,
    this.price,
    this.city,
    this.district,
    this.ward,
    this.street,
    this.requirements,
    this.numBathrooms,
    this.numBedrooms,
    this.houseDirection,
    this.balconyDirection,
    this.furnishing,
    this.frontWidth,
    this.entranceWidth,
    this.status,
    this.reviewNote,
    this.reviewedBy,
    this.isDesired,
    this.legalStatus,
    this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'lead_id': Random.secure().nextInt(10000000),
      'uploaded_by': uploadedBy,
      'title': title,
      'description': description,
      'property_type': propertyType,
      'rental_type': rentalType,
      'area': area,
      'price': price,
      'city': city,
      'district': district,
      'ward': ward,
      'street': street,
      'num_bedrooms': numBedrooms,
      'num_bathrooms': numBathrooms,
      'house_direction': houseDirection,
      'balcony_direction': balconyDirection,
      'furnishing': furnishing,
      'front_width': frontWidth,
      'entrance_width': entranceWidth,
      'status': status,
      'is_desired': isDesired,
      'requirements': requirements,
      'reviewed_by': reviewedBy,
      'review_note': reviewNote,
      'legal_status': legalStatus,
      'code': code,
    };
  }
}
