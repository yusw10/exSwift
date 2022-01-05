import UIKit

struct TestClassA {
    
    
    var B : TestClassB
}

struct TestClassB {
    
    var text : String

}

var model : TestClassB = TestClassB(text: "asdasd")



var Amodel : TestClassA = TestClassA(B: weak model)

