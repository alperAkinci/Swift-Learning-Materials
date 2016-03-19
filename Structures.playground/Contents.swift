//:# *Structures* in Swift


import UIKit
import Darwin


/*:
 ## What is *Structures* ?
 Structures, structs are named types of Swift that allow us to encapsulate related  properties and behaviors.
*/
struct Location{
    var latitude: Double
    var longitude: Double
}


/*:

### Initializing a Struct
When defining PizzaOrder , DeliveryRange structs , Swift automatically generated a default initializer .
*/
struct PizzaOrder{
    var toppings : [String]
    var size : Int
    var crust : String
}

struct DeliveryRange{
    var range : Double
    let center : Location
}
//:__-__
//: The instances of that structs uses  default initializer that takes each member as parameter
let pizzaStoreLocation = Location(latitude: 45.4232, longitude: 56.3212)
var pizzaRange = DeliveryRange(range: 300, center: pizzaStoreLocation) // mutable
let constPizzaRange = DeliveryRange(range: 400, center: pizzaStoreLocation)// immutable

//:__-__
//: Accessing member of structures
print(pizzaRange.center)
print(pizzaRange.center.latitude)

pizzaRange.range = 500

//: __IMPORTANT:__
//: As soons as we define custom initializer , Swift wont add the automatically-generated initializer.
struct TestLocation {
    var longitude : Double
    var latitude : Double
    
    //Custom initializer
    init(coordinateString : String){
        let crdSplit = coordinateString.characters.split(",")
        latitude = atof(String(crdSplit.first!))
        longitude = atof(String(crdSplit.last!))
        
    }
}

let testPizzaLocation = TestLocation(coordinateString: "42.222,12.3453")

print(testPizzaLocation.longitude)
print(testPizzaLocation.latitude)


/*:

__Mini-exercises__
1. Write an initializer for Delivery Range that takes a Location and defaults the range to 150.
*/

extension DeliveryRange{
    init(location : Location){
        range = 150
        center = location
    }
}

/*:
2. Create an initializer that takes a String for “City”or“Suburb” instead of an Int for range. Cities should have a range of 100 and suburbs a range of 150.

*/
extension DeliveryRange{
    init(city : String){
        let cityRange = 100.0
        range = cityRange
        center = pizzaStoreLocation
    }
    
    init(suburb: String){
        let suburbRange = 150.0
        range = suburbRange
        center = pizzaStoreLocation
    }
    
}

/*:

## *Self* Keyword:
- When you use self in code, you're explicitly accessing the current value of the named type.
- In other words, using dot synax on self is just like using dot syntax on a variable storing that value.
- It's especially useful in initializers: When two variables of the same name exist in the same scope, self can prevent what's known as shadowing.
*/
extension PizzaOrder{
    init(toppings: [String], size: Int) {
        self.toppings = toppings
        self.size = size
        self.crust = "Extra Crust"
    }
}


/*:

### Initializer Rules 
- By the end of the initializer, the struct must have initial values set in all of its stored properties.
- Stored properties need to be initialized with a value.
- There's one exception to the rule that stored properties must have values: optionals!
*/

struct ClimateControl {
    var temperature: Double
    var humidity: Double? = 5.0
    init(temp: Double) {
        temperature = temp
    }
}

let cold = ClimateControl(temp: 6.0)
print(cold.humidity)


/*: 

### Methods in Structs!
Much like a struct can have constants and variables, it can also define its own functions
*/

struct TestDeliveryRange {
    var range: Double
    let center: TestLocation
    func isInRange(customer: TestLocation) -> Bool {
        let difference = sqrt(pow((customer.latitude - center.latitude), 2) +
            pow((customer.longitude - center.longitude), 2))
        return difference < range
    }
}

//: isInRange method, which is now a member of DeliveryRange.

let range = TestDeliveryRange(range: 150,
    center: TestLocation(coordinateString: "44.9871,-93.2758"))
let customer = TestLocation(coordinateString: "44.9850,-93.2750")
range.isInRange(customer) // true!




/*:

## Structures as values
- Structs are known as value types.
- A value type is an object or a piece of data that is copied on assignment, which means the assignment gets an exact copy of the data rather than a reference to the very same data.
- Many of the standard Swift types are structs: Array, Float, Double, Bool, Dictionary, Set and String are all defined as structs
*/

/*:

### Note:
In contrast to many other languages such as C or Objective-C, the use of structs to define and implement core types is a unique part of Swift’s language design. Generally speaking, types such as integers, Booleans and strings are what are known as primitive types. This means they point to raw data in memory, such as the 64 bits representing an integer. Because Swift wraps those bits in a higher-level type, an Int can have methods, properties and even custom initializers!


*/

/*:

### Key points
- Structures, or structs, are a named type you can define and use in your code.
- Structs are value types.
- You use dot syntax to access the members of named types such as structs.
- Named types can have their own methods and properties, which are owned by values of those types.
- Struct initializers must set initial values to all stored properties.
- Value semantics means that values are copied on assignment.

*/

/*:


## Challenge : Clothing your structs
Create a T-shirt struct that has size, color and material options. Provide methods to calculate the cost of a shirt based on its attributes.

*/
struct Constants {
    struct Size{
        static let small = "Small"
        static let medium = "Medium"
        static let large =  "Large"
    }
    
    struct Color {
        static let blue = "Blue"
        static let black = "Red"
        static let yellow = "Yellow"
    }
    
    struct Material {
        static let cotton = "Cotton"
        static let polyester = "Polyester"
    }
}



struct Tshirt {
    var size : String
    var color : String
    var material : String
    
    func cost() -> Double{
        let baseCost = 10.0
        var sizeMultiplier : Double
        var colorMultiplier : Double
        var materialMultiplier : Double
        
        switch size {
        case Constants.Size.small : sizeMultiplier = 1.2
        case Constants.Size.medium :  sizeMultiplier = 1.3
        case Constants.Size.large :  sizeMultiplier = 1.4
        default :  sizeMultiplier = 1.0
        }
            
        switch color{
            
        case Constants.Color.black : colorMultiplier = 1.2
        case Constants.Color.blue : colorMultiplier = 1.4
        case Constants.Color.yellow : colorMultiplier = 1.6
        default : colorMultiplier = 1.0
        }
            
        switch material{
        case Constants.Material.cotton : materialMultiplier = 1.2
        case Constants.Material.polyester : materialMultiplier = 1.4
        default : materialMultiplier = 1.3
        }
        
        return (baseCost * sizeMultiplier * colorMultiplier * materialMultiplier)
        
    }
    
    
    
}

Tshirt(size: Constants.Size.small, color: Constants.Color.blue, material: Constants.Material.polyester).cost()
Tshirt(size: Constants.Size.large, color: Constants.Color.black, material: Constants.Material.cotton ).cost()








