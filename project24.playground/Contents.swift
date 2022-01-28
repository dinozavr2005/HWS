//: Playground - noun: a place where people can play

import UIKit

extension Int {
	mutating func plusOne() {
		self += 1
	}
}

var myInt = 0
myInt.plusOne()
myInt


// THIS EXTENDS ONLY INT
//extension Int {
//	func squared() -> Int {
//		return self * self
//	}
//}

// THIS EXTENDS ALL INTEGER TYPES
extension BinaryInteger {
	func squared() -> Self {
		return self * self
	}
}

let i: Int = 8
print(i.squared())


var str = "  Hello  "
str = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)


//1. Extend UIView so that it has a bounceOut(duration:) method that uses animation to scale its size down to 0.0001 over a specified number of seconds.
//2. Extend Int with a times() method that runs a closure as many times as the number is high. For example, 5.times { print("Hello!") } will print “Hello” five times.
//3. Extend Array so that it has a mutating remove(item:) method. If the item exists more than once, it should remove only the first instance it finds. Tip: you will need to add the Comparable constraint to make this work!

import UIKit
// extension 1: animate out a UIView
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y:0.0001)
            
        }
    }
    
}
// extension 2: create a times() method for integers
extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0 ..< self {
            closure()
        } }
}

// extension 3: remove an item from an array
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        } }
}
// some test code to make sure everything works
let view = UIView()
view.bounceOut(duration: 3)
5.times { print("Hello") }
var numbers = [1, 2, 3, 4, 5]
numbers.remove(item: 3)
