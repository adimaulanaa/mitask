class TaskFilterState {
  final bool isAll;
  final bool isPin;
  final bool isFav;
  final bool isArch;

  TaskFilterState({
    required this.isAll,
    required this.isPin,
    required this.isFav,
    required this.isArch,
  });

  TaskFilterState copyWith({
    bool? isAll,
    bool? isPin,
    bool? isFav,
    bool? isArch,
  }) {
    return TaskFilterState(
      isAll: isAll ?? this.isAll,
      isPin: isPin ?? this.isPin,
      isFav: isFav ?? this.isFav,
      isArch: isArch ?? this.isArch,
    );
  }

  static TaskFilterState get initial => TaskFilterState(
        isAll: true,
        isPin: false,
        isFav: false,
        isArch: false,
      );
}
