import Parsing

var input = """
./+snailTrailsV2/snailTrailsHistoryTest.m:9:    methods (TestMethodSetup)
./+snailTrailsV2/snailTrailsHistoryTest.m:21:    methods (Test, TestTags = {'req-swl-updateSnailTrail', 'req-swl-generateTrails', ...
  ./+snailTrailsV2/snailTrailsHistoryTest.m:57:    methods (Test, TestTags = {'req-swl-checkToAddTrailPoint'})
  ./+snailTrailsV2/snailTrailsHistoryTest.m:224:    methods (Test, TestTags = {'req-swl-updateSnailTrail'})
"""[...]

struct FileInfo {
  let path: [String]
  let name: String
  let line: UInt64
}

struct PathParser: Parser {
  func parse(_ input: inout Substring) throws -> FileInfo {
    let fileParser = Parse {
      PrefixThrough(".m")
      Skip { ":" }
      UInt64.parser()
      Skip { ":" }
    }.map { str, line in
      let path = str.split(separator: "/").dropLast().map { String($0) }
      let file = str.split(separator: "/").last!
      return FileInfo.init(path: path, name: String(file), line: line)
    }
    return try fileParser.parse(&input)
  }
}

let pp = PathParser()
try pp.parse(&input)
input

struct MethodParser:Parser {
  func parse(_ input: inout Substring) throws -> Void {
    try Many {
      " "
    }.parse(&input)
    try StartsWith("methods").parse(&input)
    try Many {
      " "
    }.parse(&input)
    
    try OneOf {
      StartsWith("(TestMethodSetup)")
      StartsWith("(Test)")
        // ./+lls/+parallelity/+fft/testFastFourierTransform.m:26:    methods
      StartsWith("")
    }.parse(&input)
  }
}

let methodParser = MethodParser()
  //  input = """
  //    methods   {'req-swl-updateSnailTrail', 'req-swl-generateTrails', ...
  //  """[...]
try methodParser.parse(&input)
input

  // (Test, TestTags = {'req-swl-updateSnailTrail', 'req-swl-generateTrails'

  //struct Requirement {
  //  let id:String
  //}

struct RequirementParser:Parser  {
  func parse(_ input: inout Substring) throws -> String {
    let p = Parse {
      Skip {
        PrefixUpTo("'")
        "'"
      }
      PrefixThrough("'")
    }
    let retVal = try p.parse(&input)
    return String(retVal.dropLast())
  }
}

  //let reqParser = Parse {
  //  Skip {
  //    PrefixUpTo("{'")
  //    "{'"
  //  }
  //  PrefixThrough("'")
  //}

  //let requirementsParser = Many {
  //  reqParser
  //} separator: {
  //  ","
  //}
input =
"""
   (Test, TestTags = {'req-swl-updateSnailTrail', 'req-swl-generateTrails'
"""
try RequirementParser().parse(&input)
input

input =
"""
   (Test, TestTags = {'req-swl-updateSnailTrail', 'req-swl-generateTrails'...
"""

let manyReqParser = Parse {
  Many {
    RequirementParser()
  } separator: {
    ","
  }
  OneOf {
    Skip { ", ..." }
    Skip { "})" }
  }
}
  //  .parse(&input)

  //input
  //dump(manyReq)

input =
"""
 //./+snailTrailsV2/snailTrailsHistoryTest.m:57:    methods (Test, TestTags = {'req-swl-checkToAddTrailPoint', 'req-swl-abc' })
"""

let lineParser = Parse {
  PathParser()
  MethodParser()
  manyReqParser
  Skip {
    PrefixUpTo(")")
    ")"
  }
}

  //dump(
  //  try lineParser.parse(&input)
  //)
  //input

  //let oneOfLineParser = OneOf {
  //  manyReqParser
  //  RequirementParser().map { [$0] }
  //}

input = """
./+snailTrailsV2/snailTrailsHistoryTest.m:9:    methods (TestMethodSetup)
./+snailTrailsV2/snailTrailsHistoryTest.m:21:    methods (Test, TestTags = {'req-swl-updateSnailTrail', 'req-swl-generateTrails', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:57:    methods (Test, TestTags = {'req-swl-checkToAddTrailPoint'})
./+snailTrailsV2/snailTrailsHistoryTest.m:224:    methods (Test, TestTags = {'req-swl-updateSnailTrail'})
"""

  //let mlp = Many {
  //  lineParser
  //}separator: {
  //  "\n"
  //}
  //dump(try mlp.parse(&input))
  //input

input = """
./+snailTrailsV2/snailTrailsHistoryTest.m:21:    methods (Test, TestTags = {'req-swl-updateSnailTrail'})
"""

let lp = try Parse {
  PathParser()
  MethodParser()
  manyReqParser
}

  //  .parse(&input)
  //dump(lp)
  //input


input = """
./+snailTrailsV2/snailTrailsHistoryTest.m:9:    methods (TestMethodSetup)
./+snailTrailsV2/snailTrailsHistoryTest.m:21:    methods (Test, TestTags = {'req-swl-1', 'req-swl-2', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:57:    methods (Test, TestTags = {'req-swl-3'})
./+snailTrailsV2/snailTrailsHistoryTest.m:224:    methods (Test, TestTags = {'req-swl-4'})

"""

let mlp = Many {
  lp
}separator: {
  "\n"
}
dump(try mlp.parse(&input))
input
