import 'package:dpc/src/dpc_base.dart';

/// Maps the result of a parser to a different value.
CombClosure<T> map<T, U>(CombClosure<U> parser, T Function(U) mapper) {
  return (String text) {
    var res = parser(text);
    var mapped = mapper(res.$1);
    return (mapped, res.$2);
  };
}

/// Maps the parser result to a null, discarding the matched characters
CombClosure del<T>(CombClosure<T> parser) {
  return (String text) {
    var (res, tail) = parser(text);
    return (null, tail);
  };
}

/// Cleans up a list removing all nulls
CombClosure<List<dynamic>> clear(CombClosure<List<dynamic>> parser) {
  return (String text) {
    var (res, tail) = parser(text);

    res.removeWhere((v) => v == null);

    return (res, tail);
  };
}
