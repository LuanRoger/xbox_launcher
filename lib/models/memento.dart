abstract class Memento<T> {
  List<T> mementoStack = List.empty(growable: true);

  void addToMementoStack();
  void applyFromMementoStack();
  T removeFromMementoStack();
}
