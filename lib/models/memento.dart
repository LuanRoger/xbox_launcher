abstract class Memento<T> {
  //Protected
  List<T> mementoStack = List.empty(growable: true);

  //Protected
  void addToMementoStack();
  //Protected
  void applyFromMementoStack();
  //Protected
  T removeFromMementoStack();
}
