// https://pilgwon.github.io/post/episode-1-functions
// https://www.pointfree.co/episodes/ep1-functions

//전통적인 방식

func incr(_ x: Int) -> Int {
  return x + 1
}


func square(_ x: Int) -> Int {
  return x * x
}

var result = square(incr(2)) // 9
print ("result :\(result)")


//using extension
extension Int {
  func incr() -> Int {
    return self + 1
  }

  func square() -> Int {
    return self * self
  }
}

var result2 = 2.incr().square() // 9 함수 체이닝을 이용
print ("result :\(result)")


// 파이프 연산자
precedencegroup ForwardApplication {
  associativity: left
}

infix operator |>: ForwardApplication
func |> <A, B>(a: A, f: (A) -> B) -> B {
  return f(a)
}

print("infix : \(2 |> incr) ")
print("infix : \( (2 |> incr) |> square) ")
print("infix : \(2 |> incr |> square) ")

// >>> 연산자
precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
  return { a in
    g(f(a))
  }
}

print("\(2 |> incr >>> square)")

let str = String(2.incr().square())
print(str)
// 위코드를 아래와 같이 바꿀수 있다.
print("\(2 |> incr >>> square >>> String.init)" ) //9

// map
let m = [1, 2, 3]
          .map(incr)
          .map(square)
print(m)

let m2 = [1, 2, 3].map(incr >>> square)
print(m2)
