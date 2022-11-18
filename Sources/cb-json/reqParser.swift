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

input =
"""
./+snailTrailsV2/snailTrailsHistoryTest.m:21:    methods (Test, TestTags = {'req-swl-updateSnailTrail', 'req-swl-generateTrails', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:22:        'req-swl-associateTargetIdsWithSnailTrails'})
./+snailTrailsV2/snailTrailsHistoryTest.m:57:    methods (Test, TestTags = {'req-swl-checkToAddTrailPoint'})
./+snailTrailsV2/snailTrailsHistoryTest.m:224:    methods (Test, TestTags = {'req-swl-updateSnailTrail'})
./+snailTrailsV2/snailTrailsHistoryTest.m:347:    methods (Test, TestTags = {'req-swl-detectMsts', 'req-swl-checkToAddTrailPoint', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:348:        'req-swl-trimSnailTrail'})
./+snailTrailsV2/snailTrailsHistoryTest.m:382:    methods (Test, TestTags = {'req-swl-calcLatErrorToModel'})
./+snailTrailsV2/snailTrailsHistoryTest.m:454:    methods (Test, TestTags = {'req-swl-trimSnailTrail', 'req-swl-updateSnailTrail', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:455:        'req-swl-calcLatErrorToModel'})
./+snailTrailsV2/snailTrailsHistoryTest.m:493:    methods (Test, TestTags = {'req-swl-compensateSnailTrail', 'req-swl-generateTrails', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:494:        'req-swl-trimSnailTrail', 'req-swl-updateSnailTrail'})
./+snailTrailsV2/snailTrailsHistoryTest.m:528:    methods (Test, TestTags = {'req-swl-trimSnailTrail', 'req-swl-updateSnailTrail'})
./+snailTrailsV2/snailTrailsHistoryTest.m:567:    methods (Test, TestTags = {'req-swl-detectMsts'})
./+snailTrailsV2/snailTrailsHistoryTest.m:610:    methods (Test, TestTags = {'req-swl-identifyValidSeqPoints', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:611:        'req-swl-precalcParallelityMeasure'})
./+snailTrailsV2/snailTrailsHistoryTest.m:648:    methods (Test, TestTags = {'req-swl-identifyLeastProbableMst', ...
./+snailTrailsV2/snailTrailsHistoryTest.m:649:        'req-swl-recoverMstsFromNonEtc', 'req-swl-identifyValidSeqPoints'})
./+snailTrailsV2/generateTrailsTest.m:108:    methods (Test, TestTags = {'req-swl-generateTrails'})
./+snailTrailsV2/getShiftIfFusionChangeTest.m:43:    methods (Test, TestTags = {'req-swl-updateSnailTrail'})
./+snailTrailsV2/updateSnailTrailTest.m:23:    methods (Test, TestTags = {'req-swl-updateSnailTrail'})
./+snailTrailsV2/getSnailTrailsIdTest.m:29:    methods (Test, TestTags = {'req-swl-getSnailTrailsId'})
./+snailTrailsV2/getOutputIndexTest.m:21:    methods (Test, TestTags = {'req-swl-fillPrioTrails'})
./+snailTrailsV2/trimSnailTrailTest.m:23:    methods (Test, TestTags = {'req-swl-trimSnailTrail'})
./+snailTrailsV2/associateTargetIdsWithSnailTrailsTest.m:42:    methods (Test, TestTags = {'req-swl-associateTargetIdsWithSnailTrails'})
./+snailTrailsV2/checkToAddTrailPointTest.m:25:    methods (Test, TestTags = {'req-swl-checkToAddTrailPoint'})
./+snailTrailsV2/compensateSnailTrailTest.m:88:    methods (Test, TestTags = {'req-swl-compensateSnailTrail'})
./+snailTrailsV2/confidenceTest.m:76:    methods (Test, ParameterCombination = 'exhaustive', TestTags = {'req-swl-calcConfidence'})
./+snailTrailsV2/setCoastedPointsToInvalidTest.m:36:             TestTags = {'req-swl-setCoastedPointsToInvalid'})
./+lls/+parallelity/checkMonotonicErrorTest.m:41:    methods (Test, ParameterCombination = 'sequential', TestTags = {'req-swl-checkMonotonicError'})
./+lls/+parallelity/calcParallelityMeasureTest.m:168:    methods (Test, TestTags = {'req-swl-calcParallelityMeasure'})
./+lls/+parallelity/precalcParallelityMeasureTest.m:97:    methods (Test, TestTags = {'req-swl-calcLatErrorToModel', 'req-swl-precalcParallelityMeasure'})
./+lls/+parallelity/identifyValidSeqPointsTest.m:42:    methods (Test, TestTags = {'req-swl-identifyValidSeqPoints'})
./+lls/+parallelity/+fft/findParallelTrailsTest.m:184:    methods (Test, TestTags = {'req-swl-detectMsts'})
./+lls/+parallelity/+fft/findParallelTrailsTest.m:266:    methods (Test, TestTags = {'req-swl-calcParallelityMeasure', ...
./+lls/+parallelity/+fft/findParallelTrailsTest.m:267:        'req-swl-identifyLeastProbableMst'})
./+lls/+parallelity/+fft/findParallelTrailsTest.m:288:            % req-swl-identifyLeastProbableMst.
./+lls/+parallelity/evaluateParallelityMeasureTest.m:80:        TestTags = {'req-swl-identifyLeastProbableMst', 'req-swl-recoverMstsFromNonEtc'})
./+lls/+parallelity/defineValidTrailSequenceTest.m:74:        TestTags = {'req-swl-identifyValidSeqPoints'})
./+lls/identifyLeastProbableMstTest.m:62:    methods (Test, TestTags = {'req-swl-identifyLeastProbableMst'})
./+lls/fitModelTest.m:109:    methods (Test, TestTags = {'req-swl-fitModel'})
./+lls/testSchurInvCompact.m:15:    methods (Test, TestTags = {'req-swl-computeModel'})
./+lls/testCholeskyFactorization.m:11:    methods (Test, TestTags = {'req-swl-computeModel'})
./+lls/testGatherTrailPoints.m:36:    methods (Test, TestTags = {'req-swl-gatherTrailPoints'})
./+lls/testPrecalcMats.m:50:    methods (Test, TestTags = {'req-swl-prepareLeastSquares'})
./+lls/testGenericSplineModel.m:27:    methods (Test, TestTags = {'req-swl-computeModel'})
./+lls/+prepareLeastSquares/getTrailLengthScalingTest.m:31:    methods (Test, TestTags = {'req-swl-prepareLeastSquares'})
./+lls/+prepareLeastSquares/runTest.m:95:        'req-swl-prepareLeastSquares', ...
./+lls/+prepareLeastSquares/runTest.m:96:        'req-swl-getPointProperties', ...
./+lls/+prepareLeastSquares/runTest.m:97:        'req-swl-computeModel'})
./+lls/+prepareLeastSquares/runTest.m:192:        'req-swl-prepareLeastSquares', ...
./+lls/+prepareLeastSquares/runTest.m:193:        'req-swl-getPointProperties', ...
./+lls/+prepareLeastSquares/runTest.m:194:        'req-swl-computeModel'})
./+lls/+prepareLeastSquares/accumulateTrailMatsTest.m:78:    methods (Test, TestTags = {'req-swl-prepareLeastSquares'})
./+lls/+prepareLeastSquares/checkTrailCompleteTest.m:33:    methods (Test, TestTags = {'req-swl-prepareLeastSquares'})
./+lls/removeOutlierTrailFromProperiesTest.m:20:    methods (Test, TestTags = {'req-swl-fitModel'})
./+lls/testGatherLowErrorPoints.m:61:    methods (Test, TestTags = {'req-swl-gatherLowErrorPoints'})
./+component/runtimeMeasurementTest.m:91:    methods (Test, TestTags = {'req-swl-roadFromSwarm'})
./+component/simpleComponentTest.m:138:    methods (Test, TestTags = {'req-swl-roadFromSwarm'})
./+egoTrailCluster/detectEtcTest.m:25:    methods (Test, TestTags = {'req-swl-detectEtc'})
./+egoTrailCluster/recoverMstsFromNonEtcTest.m:93:    methods (Test, TestTags = {'req-swl-recoverMstsFromNonEtc'})
./+common/calculateStdDevTest.m:21:    methods (Test, TestTags = {'req-swl-calculateStdDev'})
./+confidence/calcConfidenceTest.m:71:    methods (Test, TestTags = {'req-swl-calcConfidence'})
./+output/getTrailPriorityTest.m:23:    methods (Test, TestTags = {'req-swl-getTrailPriority'})
./+output/getTrailSetToPublishTest.m:19:    methods (Test, TestTags = {'req-swl-fillPrioTrails'})
./+output/writeOutputTrailTest.m:63:    methods (Test, TestTags = {'req-swl-writeOutputTrail'})
./+output/fillPrioTrailsTest.m:112:    methods (Test, ParameterCombination = 'sequential', TestTags = {'req-swl-fillPrioTrails', ...
./+output/fillPrioTrailsTest.m:113:            'req-swl-calcConfidence'})
./+output/fillPrioTrailsTest.m:243:    methods (Test, TestTags = {'req-swl-fillPrioTrails'})
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

  //input = """
  //./+lls/+parallelity/+fft/findParallelTrailsTest.m:267:        'req-swl-identifyLeastProbableMst'})"
  //"""

//input =
//"""
//./+output/fillPrioTrailsTest.m:112:    methods (Test, ParameterCombination = 'sequential', TestTags = {'req-swl-fillPrioTrails_1', ...
//./+output/fillPrioTrailsTest.m:113:            'req-swl-calcConfidence'})
//./+output/fillPrioTrailsTest.m:243:    methods (Test, TestTags = {'req-swl-fillPrioTrails_2'})
//"""[...]


let mlp = Many {
  lp
}separator: {
  "\n"
}
let reqmts = try mlp.parse(&input)
input

extension FileInfo:Equatable {
  static func ==(lhs:FileInfo, rhs:FileInfo) -> Bool {
    lhs.path == rhs.path
  }
}
extension Requirements:Equatable {}
extension RequirementInfo:Equatable {}

//dump(reqmts)
//reqmts.count


//let r1 = RequirementInfo(fileInfo: FileInfo(path: ["a", "b"],
//                                            name: "swarm.m",
//                                            line: 4),
//                         reqmts: Requirements(requirements: ["req-swarm-1"]))
//
//let r2 = RequirementInfo(fileInfo: FileInfo(path: ["a", "b"],
//                                            name: "swarm.m",
//                                            line: 5),
//                         reqmts: Requirements(requirements: ["req-swarm-2"]))
//
//let r12 = [r1,r2]
  //RequirementInfo.init(fileInfo: <#T##FileInfo#>, reqmts: T##Requirements)

var fr = [RequirementInfo]()

//r12.forEach { r in
//  var lr = r
//  if fr.contains(where: { r1 in
//    lr = r1
//    return r1.fileInfo.path == r.fileInfo.path
//  }) {
//
//    if let idx = fr.firstIndex(of: lr) {//firstIndex(of: r) {
//      print("exists \(lr)")
//      fr[idx].reqmts.requirements.append(contentsOf: r.reqmts.requirements)
//    }
//  } else {
//    fr.append(r)
//  }
//}
//dump(fr)

reqmts.forEach { r in
  var lr = r
  if fr.contains(where: { r1 in
    lr = r1
    return r1.fileInfo.path == r.fileInfo.path
  }) {
    
    if let idx = fr.firstIndex(of: lr) {
      r.fileInfo.line
      fr[idx].reqmts.requirements.append(contentsOf: r.reqmts.requirements )
    }
  } else {
    fr.append(r)
  }
}

//dump(reqmts.count)
//dump(fr)

extension Requirements:CustomStringConvertible {
  var description: String {
    self.requirements.joined(separator: "\n")
  }
}

extension RequirementInfo: CustomStringConvertible {
  var description: String {
    var retVal = "┃\n"
    retVal += "┃ \(self.fileInfo.name) (\(self.reqmts.requirements.count))\n"
    retVal += "┃\t\t┃ \(self.reqmts.requirements.joined(separator: "\n┃\t\t┃ ")) \n"
    retVal += "┗━━────────────────────────────────────\n"
    return retVal
  }
}

print( fr.map { r in
  r.description
}.joined(separator: "┃\n"))


//print("┃".)
