import Foundation

struct GenericIdUriName:Decodable {
  typealias Name = Tagged<GenericIdUriName, String>
  typealias Id = Tagged<GenericIdUriName, UInt64>
  
  let id:Id
  let uri:Uri
  let name:Name
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case uri = "uri"
    case name = "name"
  }
}

enum UriTag {}
typealias Uri = Tagged<UriTag, String>

struct Result:Decodable {
  typealias Id = GenericIdUriName.Id
  typealias Name = GenericIdUriName.Name
  
  let id:Id
  let name:Name
}

struct Status :Decodable {
  typealias Id = GenericIdUriName.Id
  typealias Name = GenericIdUriName.Name
  
  let id:Id
  let name:Name
  let description:String
  let flags:UInt8
}

struct Tracker:Decodable {
  typealias Project = GenericIdUriName
  typealias Id = GenericIdUriName.Id
  typealias Name = GenericIdUriName.Name
  
  let id:Id
  let uri:Uri
  let name:Name
  let project:Project
}

typealias Submitter = GenericIdUriName
typealias Modifier = GenericIdUriName
typealias Parent = GenericIdUriName
typealias TestConfiguration = GenericIdUriName
typealias Project = GenericIdUriName
typealias TestSet = GenericIdUriName
typealias Version = GenericIdUriName
typealias Versions = [GenericIdUriName]
typealias TestCase = GenericIdUriName

enum DescriptionFormat:String, Decodable {
  case plain = "Plain"
  case wiki = "Wiki"
}

struct TestRun: Decodable {
  typealias Id = Tagged<TestRun, UInt64>
  typealias Name = Tagged<TestRun, String>
  typealias Description = Tagged<TestRun, String>
  typealias ClosedAt = Tagged<TestRun, String>
  typealias SubmittedAt = Tagged<TestRun, String>
  typealias ModifiedAt = Tagged<TestRun, String>
  typealias TestCases = [[[TestCase?]?]]
  
  let id: Id
  let uri: Uri
  let version: UInt16
  let parent: Parent
  let tracker: Tracker
  let testSet: TestSet
  let name: Name
  let status: Status
  let result: Result
  let closedAt: ClosedAt
  let versions: Versions
  let testConfiguration: TestConfiguration
  let submitter: Submitter
  let modifier: Modifier
  let spentMillis: UInt64
  let submittedAt: SubmittedAt
  let modifiedAt:ModifiedAt
  let testCases:TestCases
  let descriptions:Description
  let descFormat:String
  let synectTRUID:String
  let synectTRLink:String
  let testCaseId:String
  
  enum CodingKeys: String, CodingKey {
    case id, uri, version, parent, tracker, testSet, name, status, result
    case closedAt, versions, testConfiguration, submitter
    case modifier, spentMillis, submittedAt, modifiedAt
    case descFormat, synectTRUID, synectTRLink, testCases
    case descriptions = "description"
    case testCaseId  = "_TestCase_ID"
  }
}

func decodeJson(_ data:String) ->  TestRun {
  return try! JSONDecoder().decode(TestRun.self, from: Data(data.utf8))
}

extension TestRun:CustomStringConvertible {
  var description: String {
    var result = ""
    result += "   " + String.init(repeating: "⎯", count: 50) + "\n"
    result += "   │ Test Case Name:  \(self.name.rawValue) \n"
    result += "   │ Version       :  \(self.versions.first!.name.rawValue)\n"
    result += "   │ Submitted At  :  \(self.submittedAt.rawValue) \n"
    result += "   │ Test Run by   :  \(self.submitter.name.rawValue) \n"
    result += "   │ Test Result   :  \(self.result.name == "Failed" ? "⛔️": "✅") \n"
    result += "   " + String.init(repeating: "⎯", count: 50)
    return result
  }
}
