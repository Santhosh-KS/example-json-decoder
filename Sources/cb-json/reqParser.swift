import Parsing

var input = """
./xxx/a.m:9:    methods (TestMethodSetup)
./xxx/b.m:21:    methods (Test, TestTags = {'req-swl-1', 'req-swl-2', ...
./xxx/c.m:57:    methods (Test, TestTags = {'req-swl-3'})
./yyy/d.m:224:    methods (Test, TestTags = {'req-swl-4'})
./yyy/e.m:230:    'req-swl-5'})
./yyy/d.m:231:    'req-swl-6', 'req-swl-7', ...
./yyy/d.m:232:    'req-swl-8', ...
"""[...]

struct FileInfo {
  let path: [String]
  let name: String
  let line: UInt64
}

struct Requirements {
  var requirements:[String]
}

struct RequirementInfo {
  var fileInfo: FileInfo
  var reqmts: Requirements
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
}.map(Requirements.init(requirements:))


let lp = Parse {
  PathParser()
  Many {
    lpWithReq
  }separator: {
    ", "
  }
}.map { (finfo, strs) in
  RequirementInfo.init(fileInfo: finfo, reqmts: Requirements.init(requirements: strs))
}

let mlp = Many {
  lp
}separator: {
  "\n"
}
let reqmts = try mlp.parse(&input)
input

extension FileInfo:Equatable {}
extension Requirements:Equatable {}
extension RequirementInfo:Equatable {}

var consolidatedReqmts = [RequirementInfo]()

reqmts.forEach { reqInfo in
  if consolidatedReqmts.isEmpty {
    consolidatedReqmts.append(reqInfo)
  } else {
    if !consolidatedReqmts.contains(where: { localReqinfo in
      if localReqinfo.fileInfo == reqInfo.fileInfo {
        return true
      }
      return false
    }) {
      consolidatedReqmts.append(reqInfo)
    } else {
      if let idx = consolidatedReqmts.firstIndex(of: reqInfo) {
        reqInfo
        consolidatedReqmts[idx].reqmts.requirements += reqInfo.reqmts.requirements
      }
    }
  }
}

dump(reqmts)


