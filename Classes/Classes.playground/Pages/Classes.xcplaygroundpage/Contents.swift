//:# *Classes* in Swift


import UIKit


var str = "Hello, playground"

/*:

### Classes are reference types instead of value types, have substantially different capabilities and benefits than their structure counterparts. 
While you'll often use structures in your apps to represent values,you'll generally use classes to represent objects.
*/

/*:

### Unlike a struct, a class doesn't provide initializers automatically—and that means you must provide them.
*/

class Person {
    var firsName : String
    var lastName : String
    
    //providing initializer
    init(firstName : String , lastName : String){
     self.firsName = firstName
     self.lastName = lastName
    }
    
    func fullName() -> String{
    return "\(firsName) \(lastName)"
    }

}

let alper = Person(firstName: "Alper", lastName:"Akinci")


/*:

## Reference types
 As a reference type, a class stores a pointer to a location in memory that stores the value.But as a value type, a structure stores the actual value, providing direct access to it.
### The heap vs. the stack
- When you create a reference type such as class, the system stores the actual value in a region of memory known as the heap. A value type such as a struct resides in a region of memory called the stack.
- When you create an instance of a class, your code requests a block of memory on the heap to store the object itself; it stores the address of that memory in your named variable on the stack; that's the reference stored on the left side of the diagram.
- When you create a struct, the value itself is stored on the stack, and the heap is never involved.
- When a function creates a variable, the stack stores that variable and then destroys it when the function exits. Since the stack is so well organized, it's very efficient, and thus quite fast.
- The system uses the heap to store data referenced by other objects. The heap is generally a large pool of memory from which the system can request and dynamically allocate blocks of memory. The heap doesn't automatically destroy its objects like the stack does, so you're responsible for both allocating and deallocating. This makes creating and removing data on the heap a slower process, compared to on the stack.
*/

//: In this example alper and friend are pointing to the same object.
var friend = alper
friend.lastName = "Walker"

print(alper.fullName())
print(friend.fullName())

/*:

### Object identity
In Swift, the === operator lets you check if the identity of one object is equal to the identity of another.

The === identity operator compares the memory address of two references. In other words, it tells you whether the value of the pointers on the stack are the same, meaning they point to the same block of data on the heap.
*/
var enemy = Person(firstName: "Johny", lastName: "Stalk")
var fakeAlper = Person(firstName: "Alper", lastName: "Walker")

print(alper === friend) // points the same object
print(alper === enemy)
print(alper === fakeAlper)
print(enemy === fakeAlper)

/*:

### Mini-exercise
Write a function memberOf(person: Person, group: [Group]) -> Bool that will return true if person can be found inside group, and false if it is not.
Test it by creating two arrays of five Person objects for group and using john as the person. Put john in one of the arrays, but not in the other.

*/

var group1 :[Person] = [alper,friend,enemy]
var group2 :[Person] = [fakeAlper,friend,enemy]

func memberOf(person : Person , group : [Person]) -> Bool {
    
    for member in group {
        if member === person {
            return true
            
        }else {
            return false
        }
    }
    return false
}

memberOf(alper, group: group1)
memberOf(alper, group: group2)
/*:

### Methods and mutability
Classes are mutable, it's also possible for them to mutate themselves.

*/

struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}
class Student {
    var firstName: String
    var lastName: String
    var grades: [Grade] = []
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    func recordGrade(grade: Grade) {
        grades.append(grade)
    }
    
    func calculateGPA() -> Double {
        var totalPoints : Double = 0
        var totalCredits : Double = 0
        for grade in grades{
            totalPoints += grade.points
            totalCredits += grade.credits
        }
        return totalPoints / totalCredits
    }
}

//: Note that recordGrade(_:) can mutate the array grades by adding more values to the end. 

let jane = Student(firstName: "Jane", lastName: "Appleseed")
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
let math = Grade(letter: "A", points: 16.0, credits: 4.0)
jane.recordGrade(history)
jane.recordGrade(math)

jane.calculateGPA()

/*:

### Introducing access control
Swift provides three levels of access:
- Public, meaning anyone can use the entity
- Internal, meaning any code in the same module (application or framework) can use the entity
- Private, meaning only code in the same source file can use the entity

*Internal* is Swift’s default access level for all types.
*/

public class ExplicitlyPublicClass{
    
    
    public var name = "Alper"
    private var surname = "Akıncı"
    
    //explicitly private
    private func SayHello() -> String{
     return ("Hello!")
    }
    //explicitly internal
    internal func SayHi() -> String {
     return ("Hi!")
    }
 
/*:

### Note:
"Nested" declarations such as properties or methods inside of a class or struct cannot have "greater" level of access than their nested type.
*/
    
    
    //class1 : explicitly private
    private class class1{
        // class2 : implicitly private
        class class2  {
            // number : implicitly private
            var number = 5
            internal var number2 = 10
            public var number3 = 15
        }
    }
    
}

var test = ExplicitlyPublicClass()
test.name
test.surname
test.SayHi()
test.SayHello()

/*:

### Note: 
In Swift *private* will be applied at the file level and not at the class level.
*/

var pperson = PrivatePerson(firstName: "Detective", lastName: "Gadget")

pperson.fullName()
pperson.changeFirstName("Michael")
pperson.fullName()


/*:

### When to use a class versus a struct?
Minimalist approach
 - Use only what you need. If your data will never change or you need a simple data store, then use structures. If you need to update your data and you need it to contain logic to update its own state, then use classes. Often, it's best to begin with a struct. If later you need the added capabilities of a class, then convert the struct to a class.

### Structures vs. classes recap

Structures

• Implicit copying of values

• Data is immutable

• Useful for representing values 

• Fast memory allocation (stack)

Classes

• Implicit sharing of objects

• Data is mutable

• Useful for representing things

• Slower memory allocation (heap)

### Key points

• Like structures, classes are a “named type” that can have stored properties and methods.

• Classes are references that are shared on assignment.

• Classes are mutable.

• Mutability introduces state, which adds another level of complexity whan managing your class objects.

• Use classes when you want reference semantics, and structures when you want value semantics.

*/



//: ### Challenge A: Movie lists - benefits of reference types
//:
//: • Imagine you're writing a movie-viewing application in Swift. Users can create "lists" of movies and share those lists with other users.
//:
//: • Create a User and a List class that uses reference semantics to help maintain lists between users.
class User {
    var lists : [String : List] = [:]
    
    func addList(list: List){
    lists[list.listName] = list
    }
    
    
    
}
class List {
    var listName : String
    var listMovies = Set<String>()
    
    init(name: String){
    self.listName = name
    }
    func printList(){
        print("Movie list: \(listName)")
        for movie in listMovies{
            print(movie)
        }
        print("\n")
    }
    
    func addMovieToList(movie : String){
        listMovies.insert(movie)
    }

}

let paul = User()
let simon = User()
var sportMovies = List(name: "SurfMovies")
paul.addList(sportMovies)
simon.addList(sportMovies)

simon.lists["SurfMovies"]?.listName
paul.lists["SurfMovies"]?.addMovieToList("Point Break")

paul.lists["SurfMovies"]?.printList()







