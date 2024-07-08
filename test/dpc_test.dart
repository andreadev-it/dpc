import 'package:dpc/combinators.dart';
import 'package:dpc/strings/parsers.dart';
import 'package:dpc/utils.dart';
import 'package:test/test.dart';

void main() {
  group("String parsers", () {
    test('TAG parser', () {
      var parser = tag("*");
      var input = "*test*";

      var (res, tail) = parser(input);

      expect(res, (v) => v == "*");
      expect(tail, (v) => v == "test*");
    });

    test('TAKE parser', () {
      var parser = take(2);
      var input = "hello";

      var (res, tail) = parser(input);

      expect(res, (v) => v == "he");
      expect(tail, (v) => v == "llo");
    });

    test('TAKETILL parser', () {
      var parser = takeTill((s) => s == " ");
      var input = "hello world";

      var (res, tail) = parser(input);

      expect(res, (v) => v == "hello");
      expect(tail, (v) => v == " world");
    });

    test('TAKETILL1 parser', () {
      var parser = takeTill1((s) => s == "h");
      var input = "hello world";

      expect(() => parser(input), throwsException);

      input = "what about now?";
      var (res, tail) = parser(input);

      expect(res, (s) => s == "w");
      expect(tail, (s) => s == "hat about now?");
    });
  });

  group("Combinators", () {

    test('MANY combinator', () {
      var parser = many(tag("#"));
      var input = "### Heading";

      var (res, tail) = parser(input);

      expect(res.length, (l) => l == 3);
      expect(tail, (t) => t == " Heading");
    });
  });

  group("README examples", () {
    test('Markdown links', () {
      final parser = clear(list([
          del(tag("[")),
          takeUntil("]"),
          del(tag("](")),
          takeUntil(")"),
          del(tag(")"))
      ]));

      var (value, tail) = parser("[test](https://www.github.com)");
      var [text, url] = value;

      expect(text, (t) => t == "test");
      expect(url, (u) => u == "https://www.github.com");
    });
  });
}
