# TDD Notes

1) Tests you should already have in StackAppTests target:
- StackTests.swift
- CommandParserTests.swift
- OutputFormattingTests.swift

2) Next steps:
- Run Product > Test. All tests should compile and mostly pass; if any assertion mismatches formatting, adjust implementation or tests to match the agreed strings.

3) Implementation order if you want to grow features:
- Keep all logic in these simple types. UI can call:
  - let parse = CommandParser.parse(input)
  - switch parse:
    - .success(.push(n)): stack.push(n); show OutputFormatter.formatPush(...)
    - .success(.pop): stack.pop(); show OutputFormatter.formatPop(...)
    - .success(.quit): show OutputFormatter.formatQuit()
    - .failure(msg): show OutputFormatter.formatParseError(msg, contents: stack.contents)
