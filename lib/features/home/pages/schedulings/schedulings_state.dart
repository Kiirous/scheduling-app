part of 'schedulings_cubit.dart';

class SchedulingsState extends Equatable {
  const SchedulingsState({
    this.isLoading = false,
    this.page = 0,
    this.finishedLoading = false,
    List<Scheduling>? schedulings,
  }) : _schedulings = schedulings;

  final bool isLoading;
  final int page;
  final bool finishedLoading;

  final List<Scheduling>? _schedulings;

  UnmodifiableListView<Scheduling>? get schedulings =>
      _schedulings != null ? UnmodifiableListView(_schedulings) : null;

  @override
  List<Object?> get props => [isLoading, schedulings, page, finishedLoading];

  SchedulingsState copyWith({bool? isLoading, List<Scheduling>? schedulings, int? page, bool? finishedLoading}) {
    return SchedulingsState(
      isLoading: isLoading ?? this.isLoading,
      schedulings: schedulings ?? _schedulings,
      page: page ?? this.page,
      finishedLoading: finishedLoading ?? this.finishedLoading,
    );
  }
}
