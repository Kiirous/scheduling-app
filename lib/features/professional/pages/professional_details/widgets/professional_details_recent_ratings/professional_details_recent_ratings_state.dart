part of 'professional_details_recent_ratings_cubit.dart';

enum ProfessionalDetailsRecentRatingsStatus { loading, success, error }

class ProfessionalDetailsRecentRatingsState extends Equatable {
  const ProfessionalDetailsRecentRatingsState({
    this.ratings,
    this.status = ProfessionalDetailsRecentRatingsStatus.loading,
  });

  final ProfessionalDetailsRecentRatingsStatus status;
  final List<Rating>? ratings;

  bool get isSuccess => status == ProfessionalDetailsRecentRatingsStatus.success;

  @override
  List<Object?> get props => [ratings, status];

  ProfessionalDetailsRecentRatingsState copyWith({
    ProfessionalDetailsRecentRatingsStatus? status,
    List<Rating>? ratings,
  }) {
    return ProfessionalDetailsRecentRatingsState(status: status ?? this.status, ratings: ratings ?? this.ratings);
  }
}
