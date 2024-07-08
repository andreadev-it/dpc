import "../src/dpc_base.dart";

/// Check that the string begins with [txt]
CombClosure<String> tag(String txt) {
  return (String text) {
    if (!text.startsWith(txt)) {
      throw Exception("Expected to find '$txt'");
    }

    return (text.substring(0, txt.length), text.substring(txt.length));
  };
}

/// Takes [len] characters from the input string
CombClosure<String> take(int len) {
  return (String text) {
    if (text.length < len) {
      throw Exception("Not enough characters. Expected $len");
    }

    return (text.substring(0, len), text.substring(len));
  };
}

/// Takes any amount of characters until the predicate returns true
CombClosure<String> takeTill(bool Function(String) foo) {
  return (String text) {
    var i = 0;
    String res = "";
    while (i < text.length && !foo(text[i])) {
      res += text[i];
      i++;
    }

    return (res, text.substring(i));
  };
}

/// Takes one or more characters until the predicate returns true
CombClosure<String> takeTill1(bool Function(String) foo) {
  return (String text) {
    var i = 0;
    String res = "";
    while (i < text.length && !foo(text[i])) {
      res += text[i];
      i++;
    }

    if (i == 0) {
      throw Exception("Expected at least one character before matching the predicate.");
    }

    return (res, text.substring(i));
  };
}

/// Takes any amount of characters until it finds the specified [tag]
CombClosure<String> takeUntil(String tag) {
  return (String text) {
    var idx = text.indexOf(tag);

    if (idx == -1) {
      return (text, "");
    }

    return (text.substring(0, idx), text.substring(idx));
  };
}

/// Takes one or more characters until it finds the specified [tag]
CombClosure<String> takeUntil1(String tag) {
  return (String text) {
    var idx = text.indexOf(tag);

    if (idx == -1) {
      return (text, "");
    }

    if (idx == 0) {
      throw Exception("Expected characters before '$tag'");
    }

    return (text.substring(0, idx), text.substring(idx));
  };
}

/// Takes any number of characters as long as the predicate returns true
CombClosure<String> takeWhile(bool Function(String) predicate) {
  return (String text) {
    var i = 0;
    String res = "";

    while (i < text.length && predicate(text[i])) {
      res += text[i];
      i++;
    }

    return (res, text.substring(i));
  };
}

/// Takes one or more characters as long as the predicate returns true
CombClosure<String> takeWhile1(bool Function(String) predicate) {
  return (String text) {
    var i = 0;
    String res = "";

    while (i < text.length && predicate(text[i])) {
      res += text[i];
      i++;
    }

    if (i == 0) {
      throw Exception("Expected at least one character matching a predicate.");
    }

    return (res, text.substring(i));
  };
}

/// Matches everything that is left to parse
CombRes<String> takeAll(String text) {
  return (text, "");
}




