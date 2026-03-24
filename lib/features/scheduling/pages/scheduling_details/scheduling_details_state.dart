part of 'scheduling_details_cubit.dart';

class SchedulingDetailsState extends Equatable {
  const SchedulingDetailsState({required this.isLoading, required this.scheduling});

  const SchedulingDetailsState.initial() : isLoading = false, scheduling = null;

  final bool isLoading;
  final Scheduling? scheduling;

  @override
  List<Object?> get props => [isLoading, scheduling];

  SchedulingDetailsState copyWith({bool? isLoading, Scheduling? scheduling}) {
    return SchedulingDetailsState(isLoading: isLoading ?? this.isLoading, scheduling: scheduling ?? this.scheduling);
  }
}
