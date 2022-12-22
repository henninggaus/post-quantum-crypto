import 'package:post_quantum_crypto/post_quantum_crypto.dart';
import 'package:test/test.dart';

void main() {
  print('Hello World');

  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
