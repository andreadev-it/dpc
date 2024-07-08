import 'package:dpc/src/dpc_base.dart';

/// Tries matching the [parser]. If it doesn't work, returns a null, but
/// does not interrupt parsing.
CombClosure<T?> opt<T>(CombClosure<T> parser) {
  return (String text) {
    try {
      var res = parser(text);

      return res;
    } catch (e) {
      return (null, text);
    }
  };
}

/// Matches the parsers one by one, returning the value of the first one
/// that succedes
CombClosure<dynamic> alt(List<CombClosure<dynamic>> parsers) {
  return (String text) {
    for (final parser in parsers) {
      try {
        var res = parser(text);
        return res;
      } catch (e) {
        // don't do anything, just let the loop go
      }
    }

    throw Exception("Expected one of multiple parsers to pass");
  };
}

/// Matches a list of parsers, one right after the other, in the list order
CombClosure<List<dynamic>> list(List<CombClosure<dynamic>> parsers) {
  return (String text) {
    List<dynamic> totalRes = [];
    String tail = text;
    for (final parser in parsers) {
      var res = parser(tail);
      totalRes.add(res.$1);
      tail = res.$2;
    }

    return (totalRes, tail);
  };
}

/// Tries to run a parser multiple times
CombClosure<List<T>> many<T>(CombClosure<T> parser) {
  return (String text) {
    List<T> totalRes = [];
    var tail = text;

    try {
      while (tail.length > 0) {
        var (res, parserTail) = parser(tail);
        totalRes.add(res);
        tail = parserTail;
      }
    } catch (e) {
      // do nothing, actually
    }

    return (totalRes, tail);
  };
}
