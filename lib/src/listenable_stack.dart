library listenable_undo;

import 'package:flutter/foundation.dart';
import 'package:listenable_undo/src/undo_stack.dart';

class ListenableStack extends ChangeStack with ChangeNotifier {
  @override
  void add<T>(Change<T> change) {
    super.add(change);
    notifyListeners();
  }

  @override
  void addGroup<T>(List<Change<T>> changes) {
    super.addGroup(changes);
    notifyListeners();
  }

  @override
  void undo() {
    if (canUndo) {
      super.undo();
      notifyListeners();
    }
  }

  @override
  void redo() {
    if (canRedo) {
      super.redo();
      notifyListeners();
    }
  }

  @override
  void clearHistory() {
    if (canUndo || canRedo) {
      super.clearHistory();
      notifyListeners();
    }
  }
}
