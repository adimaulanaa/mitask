import 'package:mitask/features/task/domain/entities/task_filter_state.dart';

class SelectTaskFilterUseCase {
  TaskFilterState call(TaskFilterState current, int idx) {
    bool isAll = current.isAll;
    bool isPin = current.isPin;
    bool isFav = current.isFav;
    bool isArch = current.isArch;

    if (idx == 0) {
      // pilih ALL
      return TaskFilterState(
        isAll: true,
        isPin: false,
        isFav: false,
        isArch: false,
      );
    }

    if (idx == 1) {
      isPin = !isPin;
      isAll = false;
    } else if (idx == 2) {
      isFav = !isFav;
      isAll = false;
    } else if (idx == 3) {
      isArch = !isArch;
      isAll = false;
    }

    // otomatis set ALL
    if (!isPin && !isFav && !isArch) {
      isAll = true;
    }

    return TaskFilterState(
      isAll: isAll,
      isPin: isPin,
      isFav: isFav,
      isArch: isArch,
    );
  }
}
