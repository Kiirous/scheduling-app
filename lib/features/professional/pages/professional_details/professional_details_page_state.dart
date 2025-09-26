part of 'professional_details_page_cubit.dart';

class ProfessionalDetailsPageState extends Equatable {
  const ProfessionalDetailsPageState({this.professional});

  final Professional? professional;

  @override
  List<Object?> get props => [professional];
}