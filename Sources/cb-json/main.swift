import Foundation

let urls = CommandLine.arguments.dropFirst()
  .map { URL(fileURLWithPath: $0) }


for url in urls {
  print(url)
  do {
    let data = try String(contentsOf: url)
    let result = decodeJson(data)
    print(result)
  }catch {
    print("Couldn't extract the file: \(url.absoluteString)")
  }
}


