// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeadModelImpl _$$LeadModelImplFromJson(Map<String, dynamic> json) =>
    _$LeadModelImpl(
      leadId: json['lead_id'] as num?,
      uploadedBy: json['uploaded_by'] as num?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      propertyType: json['property_type'] as String?,
      rentalType: json['rental_type'] as String?,
      area: json['area'] as num?,
      price: json['price'] as num?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      ward: json['ward'] as String?,
      street: json['street'] as String?,
      requirements: json['requirements'] as String?,
      numBedrooms: json['num_bedrooms'] as num?,
      numBathrooms: json['num_bathrooms'] as num?,
      houseDirection: json['house_direction'] as String?,
      balconyDirection: json['balcony_direction'] as String?,
      furnishing: json['furnishing'] as String?,
      frontWidth: json['front_width'] as num?,
      entranceWidth: json['entrance_width'] as num?,
      status: json['status'] as String?,
      reviewedBy: json['reviewed_by'] as num?,
      reviewNote: json['review_note'] as String?,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isDesired: json['is_desired'],
      postId: json['post_id'] as num?,
      code: json['code'] as String?,
      legalStatus: json['legal_status'] as String?,
      legalDocuments: json['legal_documents'] as String?,
    );

Map<String, dynamic> _$$LeadModelImplToJson(_$LeadModelImpl instance) =>
    <String, dynamic>{
      'lead_id': instance.leadId,
      'uploaded_by': instance.uploadedBy,
      'title': instance.title,
      'description': instance.description,
      'property_type': instance.propertyType,
      'rental_type': instance.rentalType,
      'area': instance.area,
      'price': instance.price,
      'city': instance.city,
      'district': instance.district,
      'ward': instance.ward,
      'street': instance.street,
      'requirements': instance.requirements,
      'num_bedrooms': instance.numBedrooms,
      'num_bathrooms': instance.numBathrooms,
      'house_direction': instance.houseDirection,
      'balcony_direction': instance.balconyDirection,
      'furnishing': instance.furnishing,
      'front_width': instance.frontWidth,
      'entrance_width': instance.entranceWidth,
      'status': instance.status,
      'reviewed_by': instance.reviewedBy,
      'review_note': instance.reviewNote,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_desired': instance.isDesired,
      'post_id': instance.postId,
      'code': instance.code,
      'legal_status': instance.legalStatus,
      'legal_documents': instance.legalDocuments,
    };
