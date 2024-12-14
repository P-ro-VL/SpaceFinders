import 'dart:math';

extension RandomPicker<T> on List<T> {
  List<T> pickRandomItems(int n) {
    if (n <= 0 || isEmpty) {
      return [];
    }

    if (n >= length) {
      return List<T>.from(this);
    }

    // Generate a set of random unique indices.
    final random = Random();
    final selectedIndices = <int>{};

    while (selectedIndices.length < n) {
      selectedIndices.add(random.nextInt(length));
    }

    final result =
        selectedIndices.toList().map((index) => this[index]).toList();

    return result;
  }
}
