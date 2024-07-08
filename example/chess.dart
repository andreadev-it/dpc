import "package:dpc/dpc.dart";
// How a chess move is encoded: https://en.wikipedia.org/wiki/Algebraic_notation_(chess)
// This is only meant as a demonstration, it is not an infallible parser

void main() {
  // This matches the movement of a player
  // Examples: 
  // - Nf3xd2
  // - e4
  // - Re3+
  var single = list([
    opt(piece),
    opt(column),
    opt(row),
    opt(tag("x")),
    opt(list([
      column,
      row 
    ])),
    opt(alt([
      tag("+"),
      tag("#"),
      list([
        tag("="),
        take(1)
      ])
    ]))
  ]);

  // This matches either a castling or a normal move
  var action = alt([
    tag("O-O-O"),
    tag("O-O"),
    single,
  ]);

  // This matches a single row in the notation (move by both white and black)
  var move = list([
    takeWhile(isDigit),
    tag('. '),
    action,
    tag(' '),
    action,
    opt(tag(' '))
  ]);

  // This checks for as many moves as possible, and requiring a full match
  var allMoves = fullMatch(many(move));

  var input = "1. f3 e6 2. g4 Qh4#";

  var (res, tail) = allMoves(input);
  print(res);
  print(tail);

  var malformed = "1. f3 e6 2. gN4 Qh4#";

  try {
    var t = allMoves(malformed);
    print(t);
  } catch (e) {
    print("Tried to parse a malformed notation.");
  }
}

// Now follow many different utility functions

// Parser for a piece
CombRes<Piece> piece(String text) {
  var parser = map(alt([
    tag("K"),
    tag("Q"),
    tag("B"),
    tag("N"),
    tag("R"),
  ]), (dynamic x) => toPiece(x as String));

  return parser(text);
}

// Parser for a column (very lazy way to do it)
CombRes<dynamic> column(String text) {
  var parser = alt([
    tag("a"),
    tag("b"),
    tag("c"),
    tag("d"),
    tag("e"),
    tag("f"),
    tag("g"),
    tag("h"),
  ]);

  return parser(text);
}

// Parser for a row (very lazy way to do it)
CombRes<int> row(String text) {
  var parser = map(
    alt([
      tag("1"),
      tag("2"),
      tag("3"),
      tag("4"),
      tag("5"),
      tag("6"),
      tag("7"),
      tag("8"),
    ]),
    (c) => int.parse(c as String)
  );

  return parser(text);
}

bool isDigit(String s) {
  return int.tryParse(s) != null;
}

enum Piece {
  King,
  Queen,
  Bishop,
  Knight,
  Rook,
  Pawn
}

Piece toPiece(String? s) {
  switch (s) {
    case 'K':
      return Piece.King;
    case 'Q':
      return Piece.Queen;
    case 'B':
      return Piece.Bishop;
    case 'N':
      return Piece.Knight;
    case 'R':
      return Piece.Rook;
    default:
      return Piece.Pawn;
  };
}
