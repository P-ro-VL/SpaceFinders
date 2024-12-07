import 'package:either_dart/either.dart';
import 'package:spacefinder/domain/repository/lead_repository.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

class UpdateLeadUseCase
    extends UseCase<Either<FailureEntity, bool>, UpdateLeadParams> {
  final LeadRepository repository;

  UpdateLeadUseCase(this.repository);

  @override
  Future<Either<FailureEntity, bool>> call(UpdateLeadParams params) async {
    return await repository.updateLead(params);
  }
}

class UpdateLeadParams {
  final num? leadId;
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

  UpdateLeadParams(this.leadId,
      {this.uploadedBy,
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
      this.isDesired});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if (title != null) json['title'] = title;
    if (description != null) json['description'] = description;
    if (propertyType != null) json['property_type'] = propertyType;
    if (rentalType != null) json['rental_type'] = rentalType;
    if (area != null) json['area'] = area;
    if (price != null) json['price'] = price;
    if (city != null) json['city'] = city;
    if (district != null) json['district'] = district;
    if (ward != null) json['ward'] = ward;
    if (street != null) json['street'] = street;
    if (requirements != null) json['requirements'] = requirements;
    if (numBedrooms != null) json['num_bedrooms'] = numBedrooms;
    if (numBathrooms != null) json['num_bathrooms'] = numBathrooms;
    if (houseDirection != null) json['house_direction'] = houseDirection;
    if (balconyDirection != null) json['balcony_direction'] = balconyDirection;
    if (furnishing != null) json['furnishing'] = furnishing;
    if (frontWidth != null) json['front_width'] = frontWidth;
    if (entranceWidth != null) json['entrance_width'] = entranceWidth;
    if (status != null) json['status'] = status;
    if (reviewedBy != null) json['reviewed_by'] = reviewedBy;
    if (reviewNote != null) json['review_note'] = reviewNote;
    if (isDesired != null) json['is_desired'] = isDesired;

    return json;
  }
}
