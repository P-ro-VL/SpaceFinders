class LeadEntity {
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
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic isDesired;
  final String? code;
  final String? legalDocuments;
  final String? legalStatus;

  String? uploadedByName;
  String? reviewedByName;

  LeadEntity({
    this.leadId,
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
    this.createdAt,
    this.updatedAt,
    this.isDesired,
    this.code,
    this.legalStatus,
    this.legalDocuments,
  });
}
