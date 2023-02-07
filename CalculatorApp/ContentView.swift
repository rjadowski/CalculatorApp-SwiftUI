//
//  ContentView.swift
//  Calculator
//
//  Created by Robbie Jadowski on 03/02/23
//
import SwiftUI

// Enum that represents the buttons in a calculator
enum CalcButton: String {
    // Numeric buttons
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    
    // Operation buttons
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    
    // Other buttons
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    // Returns the color of the button based on its type
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            // Orange color for operation buttons
            return .purple
        case .clear, .negative, .percent:
            // Light gray color for other buttons
            return Color(.lightGray)
        default:
            // Dark gray color for numeric buttons
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}


enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    // State variables to store values
    @State var value = "0" // display value
    @State var runningNumber = 0.0 // current calculation result
    @State var currentOperation: Operation = .none // current operation
    
    // Matrix of buttons
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    // Body view
    var body: some View {
        ZStack {
            // Black background
            Color.init(uiColor: UIColor(red: 22/255.0, green: 22/255.0, blue: 22/255.0, alpha: 1)).ignoresSafeArea(.all)
            
            // Main view stack
            VStack {
                Spacer()
                
                // Text display
                HStack {
                    Spacer()
                    Text(value.count <= 9 || Double(value) == nil ? value : String(format: "%e", Double(value)!))
                    .bold()
                    .font(.system(size: value.count > 5 ? 50 : 100))
                    .foregroundColor(.white)
                }
                .padding()
                
                
                
                // Loop through button matrix to create button rows
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        // Loop through button rows to create individual buttons
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                // Call didTap function when button is tapped
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    // The didTap method is called when a button on the calculator is tapped.
    // It takes in a CalcButton as an argument.
    func didTap(button: CalcButton) {
        // Check the value of the button passed in as an argument.
        switch button {
            // For the numeric buttons, append the button's value to the display value.
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            // Check if the value is already 9 digits long, if it is, don't append any more digits.
            if value.count >= 9 { return }
            value = value == "0" ? button.rawValue : value + button.rawValue
        case .add, .subtract, .multiply, .divide, .equal:
            // Check which type of button was tapped.
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .equal {
                // Perform the operation based on the current operation type.
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            // If the button is not the equal button, reset the value to 0.
            if button != .equal {
                self.value = "0"
            }
            // For the clear button, reset the value to 0.
        case .clear:
            self.value = "0"
            // For the decimal button, add a decimal point to the value if it does not already contain one.
        case .decimal:
            if !self.value.contains(".") {
                self.value = "\(self.value)."
            }
            // For the negative button, toggle the negative sign on the value.
        case .negative:
            if self.value.first == "-" {
                self.value.removeFirst()
            } else {
                self.value = "-\(self.value)"
            }
            // For the percent button, convert the value to a percentage.
        case .percent:
            let currentValue = Double(self.value) ?? 0
            self.value = "\(currentValue / 100.0)"
            // For the number buttons, update the value.
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    
    // This function calculates the width of a calculator button based on its type
    func buttonWidth(item: CalcButton) -> CGFloat {
        // If the button is the zero button, its width should be twice the width of a regular button
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        // Otherwise, the width of a regular button is calculated by dividing the screen width by 4, then subtracting the sum of the spacings between the buttons
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    // This function calculates the height of a calculator button
    func buttonHeight() -> CGFloat {
        // The height is equal to the width, calculated in the same manner as the width
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
