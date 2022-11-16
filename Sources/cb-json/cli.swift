import Foundation

struct drive:RawRepresentable {
  let rawValue: String
}

enum operatingSystem: RawRepresentable {
  typealias RawValue = String
  
  case linux, mac, windows(drive)

  var rawValue: String {
    switch self {
      case .linux:
        return "linux"
      case .mac:
        return "mac"
      case let .windows(drive):
        return "windows" + (drive.rawValue.count > 0 ? " with \(drive.rawValue): Drive" : "")
    }
  }
  
  init?(rawValue: String) {
    switch rawValue.lowercased() {
      case "linux": self = .linux
      case "unix": self = .linux
      case "mac": self = .mac
      case "windows":self = .windows(drive(rawValue: "C:"))
      default : self = .linux
        
    }
  }
}

func separatorType(_ os:operatingSystem) -> String {
  switch os {
    case .windows: return "\\"
    default: return "/"
  }
}

enum folder:String, CaseIterable {
  case usr, bin, etc, home, lib, mnt, opt, proc, root, sbin, sys, `var`, tmp, local
}

enum command:String, CaseIterable {
  case ls, find, grep, bash
}

extension String {
  func prepend(with prefix:String) -> String {
    prefix + self
  }
}

func path<A>(_ xs:[A],
             separator:String = separatorType(.linux)) -> String
where A: RawRepresentable,
      A.RawValue: StringProtocol {
  xs.map { $0.rawValue }
    .joined(separator: separator)
    .prepend(with: separator)
    .appending(separator)
}

func commandPath<A>(for cmd:command, with p:[A], os:operatingSystem = .linux) -> String
where A: RawRepresentable,
      A.RawValue: StringProtocol {
  switch cmd {
    default: return path(p, separator: separatorType(os)) + cmd.rawValue
  }
}

func commandPath(_ cmd:command, _ os:operatingSystem = .linux) -> String {
  switch cmd {
    case .ls:
      return path([folder.bin], separator: separatorType(os)) + cmd.rawValue
    case .find:
      fallthrough
    case .grep:
      fallthrough
    case .bash:
      return path([folder.usr, .bin]) + cmd.rawValue
  }
}

let cli = Array<String>(CommandLine.arguments.dropFirst())

struct Shell {
  let cmd:command
  let path:[folder]
  var os: () -> operatingSystem
}

extension Shell {
  func run(_ arguments: [String] = []) -> (String?, Int32) {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: commandPath(self.cmd))
    task.arguments = arguments
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    
    do {
      try task.run()
    } catch {
        // handle errors
      print("Error: \(error.localizedDescription)")
    }
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)
    
    task.waitUntilExit()
    
    return (output, task.terminationStatus)
  }
}

let ls = Shell(cmd: .ls, path: [.bin]) { .linux }

let (output, errorCode) = ls.run(cli)
if errorCode == 0, let op = output {
  print(op)
}
else {
  print("ERROR:\(commandPath(ls.cmd)) \(cli.joined(separator: " ")) failed with \(errorCode)")
}
