
A simple SwiftUI calculator app.


The app consists of a ContentView struct that implements the SwiftUI View protocol. The main view has a black background with a white text display and a matrix of buttons. The display shows the results of calculations performed using the buttons.

The ContentView has state variables to store values such as the display value, current calculation result, and current operation. The matrix of buttons is created using a two-dimensional array of the CalcButton enum. The CalcButton enum represents the buttons in a calculator and provides information about the color of the button based on its type (numeric, operation, or other).

The didTap method is called when a button on the calculator is tapped. It takes in a CalcButton as an argument and performs operations based on the button type (add, subtract, multiply, divide, equal, clear, decimal, percent, or negative).

Requirements

Xcode 11 or later

Swift 5 or later

iOS 13.0 or later

How to Run

Clone or download the repository.

Open the project in Xcode.

Choose the simulator or your connected iOS device as the target.

Press the Run button or use the Cmd + R keyboard shortcut to build and run the app.

