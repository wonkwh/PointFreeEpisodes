import Foundation

//founddation에 string을 parsing하여 init하는 많은 type들
Int("42") //42
Int("42-") //nil

Double("42")
Double("42.42430")

Bool("true") //true
Bool("false") //false
Bool("f") //nil

UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")
UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBE") //nil
UUID(uuidString: "DEADBEEF-DEAD-BEEF-DAD-BEEFDEADBE") //nil

URL(string: "https://wonkwh.github.com")
URL(string: "htps://wonkwh.github.com")

let urlComponents = URLComponents(string: "https://swiftsenpai.com/development/reduce-uiimage-memory-footprint/?ref=facebook")
urlComponents?.queryItems //[name:"ref", value:"facebook"]

// 조금더 복잡한 parser
let df = DateFormatter()
df.timeStyle = .none
df.dateStyle = .short
df.date(from: "3/12/22") // "Dec 22, 3 12:00 AM"
df.date(from: "-3/12/22") // nil parser fail

//email을 parsing하는 regular expression
let emailRegexp = try NSRegularExpression(pattern: #"\S+@\S+"#)
let emailString = "You're logged in as wonkwh@gmail.com"
let emailRange = emailString.startIndex..<emailString.endIndex
let match = emailRegexp.firstMatch(
  in: emailString,
  range: NSRange(emailRange, in: emailString)
)!
emailString[Range(match.range(at: 0), in: emailString)!]


//Scanner을 이용한 paring
let scanner = Scanner(string: "42 hello world")
var int: Int = 0
scanner.scanInt(&int)
int //42

//다음과 같은 위도, 경도 문자열을 parsing하는 바닥부터 구현해보자
// 40.6782° N, 73.9442° W

struct Coordinate {
  let latitude: Double
  let longitude: Double
}

func parseLatLong(_ string: String) -> Coordinate? {
      let parts = string.split(separator: " ")
      guard parts.count == 4 else { return nil }
      guard
        let lat = Double(parts[0].dropLast()),
        let long = Double(parts[2].dropLast())
      else { return nil }
      let latCard = parts[1].dropLast()
      guard latCard == "N" || latCard == "S" else { return nil }
      let longCard = parts[3]
      guard longCard == "E" || latCard == "W" else { return nil }
      let latSign = latCard == "N" ? 1.0 : -1
      let longSign = longCard == "E" ? 1.0 : -1
      return Coordinate(latitude: lat * latSign, longitude: long * longSign)
    }

print( parseLatLong("40.6782° N, 73.9442° W") ?? "")
print(parseLatLong("40.6782° X, 73.9442° W"))
print(parseLatLong("40.6782% N- 73.9442% W"))
