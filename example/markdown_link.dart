import 'package:dpc/dpc.dart';

void main() {
  final parser = clear(list([
      del(tag("[")),
      takeUntil("]"),
      del(tag("](")),
      takeUntil(")"),
      del(tag(")"))
  ]));

  var (value, tail) = parser("[test](https://www.github.com)");
  var [text, url] = value;

  print("Text '$text' links to url '$url'");
}
