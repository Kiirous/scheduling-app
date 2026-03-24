import 'package:app_agendamento/features/professional/models/insurance.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:app_agendamento/features/professional/models/service.dart';
import 'package:app_agendamento/features/professional/models/specialty.dart';

class ProfessionalDetails extends Professional {
  const ProfessionalDetails({
    required super.id,
    required super.name,
    super.picture,
    required super.rating,
    required super.ratingCount,
    required this.address,
    required this.phone,
    required super.crm,
    required this.services,
    required this.specialties,
    required this.insurances,
  });

  final String address;
  final String phone;
  final List<Service> services;
  final List<Specialty> specialties;
  final List<Insurance> insurances;

  factory ProfessionalDetails.fromJson(Map<String, dynamic> map) {
    return ProfessionalDetails(
      id: map['id'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      rating: map['rating'] as num,
      ratingCount: map['ratingCount'] as int,
      address: map['address'] as String,
      phone: map['phone'] as String,
      crm: map['crm'] as String,
      services: map['services'].map<Service>((s) => Service.fromJson(s)).toList(),
      specialties: map['specialties'].map<Specialty>((s) => Specialty.fromJson(s)).toList(),
      insurances: map['insurances'].map<Insurance>((s) => Insurance.fromJson(s)).toList(),
    );
  }
}
