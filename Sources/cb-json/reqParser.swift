import Parsing

var input = """
./+snailTrailsV2/snailTrailsHistoryTest.m:9:    methods (TestMethodSetup)
./+snailTrailsV2/snailTrailsHistoryTest.m:21:    methods (Test, TestTags = {'req-swl-1', 'req-swl-2', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:57:    methods (Test, TestTags = {'req-swl-3'})
./+snailTrailsV2/snailTrailsHistoryTest.m:224:    methods (Test, TestTags = {'req-swl-4'})
./+snailTrailsV2/snailTrailsHistoryTest.m:230:    'req-swl-5'})
./+snailTrailsV2/snailTrailsHistoryTest.m:230:    'req-swl-6', 'req-swl-7', ...
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

try methodParser.parse(&input)
input

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

let manyReqParser = Parse {
  Many {
    RequirementParser()
  } separator: {
    ","
  }
  OneOf {
    Skip { ", ..." }
    Skip { ")" }
  }
}

let p = OneOf {
  Skip {
    PrefixUpTo("{")
    "{"
  }
  Skip {
    PrefixUpTo(")")
  }
}


let ending = OneOf {
  Skip { "})" }
//  Skip { "}" }
  Skip { ")" }
  Skip { ", ..."}
 
}

let lpWithReq = Parse {
  RequirementParser()
  OneOf {
    Skip { ", ..."}
    Skip { "})" }
    Skip { ""}
  }
}

let lpWithNoReq = Parse {
  Skip {
    PrefixUpTo("(")
    PrefixUpTo(")")
  }
}

let req = OneOf {
  lpWithNoReq.map { [""] }
//  lpWithReq.map { [$0] }
  Many {
    lpWithReq
  }separator: {
    ", "
  }
}

let lp = Parse {
  PathParser()
  Many {
    lpWithReq
  }separator: {
    ", "
  }
}

let mlp = Many {
  lp
}separator: {
  "\n"
}
dump(try mlp.parse(&input))
input
