//: [Previous](@previous)

import Foundation

//parser란 String을 어떤 임의에 타입으로 변경하는것

struct Parser<T> {
    let run: (String) -> T?
}

// deep-link routing을 parser로
enum Route {
    case home
    case profile
    case episode
    case episodes(id: Int)
}

let route = Parser<Route> { str in
    print(str)
    return .home
}

route.run("/")

/*
switch route.run("/episodes/43") {
case .none:
    
case .some(.home):

case .some(.profile):
case .some(.episode):
case let .some(.episodes(id)):
}
*/

// command line tools 을 parser로
enum EnumPropertyGenerator {
    case help
    case version
    case invoke(urls: [URL], dryRun: Bool)
}

let cli = Parser<EnumPropertyGenerator> { (String) -> EnumPropertyGenerator? in
    return nil
}

cli.run("generate-enum-properties --version")
cli.run("generate-enum-properties --help")
cli.run("generate-enum-properties --dry-run path/to/file")

/*
switch cli.run("generate-enum-properties --dry-run path/to/file") {
    case .none:
    case .some(.help):
    case .some(.version):
    case let .some(.invoke(urls, dryRun)):
}
 */

//: [Next](@next)
