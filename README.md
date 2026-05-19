# Test Score Calculator (LC-3)

## Introduction
This project is an LC-3 assembly program that calculates the minimum, maximum, and average of five test scores entered by the user. It also displays the corresponding letter grade for each value. The purpose of this project is to practice low level programming concepts such as memory usage, branching, subroutines, and stack operations.

## Technologies
- LC-3 Assembly Language
- LC-3 Simulator

## Features
- Accepts five test scores from the user
- Stores values using an array
- Calculates minimum score
- Calculates maximum score
- Calculates average score
- Displays letter grades based on score ranges
- Uses subroutines for modular design
- Implements stack operations (push and pop)
- Uses branching for loops and conditions
- Performs ASCII conversion for input and output

## How to Run

Option 1:
- Assemble the program
- Open the simulator software
- Load the assembled (.obj) file
- Run the program and view output in the console

Option 2:
- Open any online LC-3 simulator (for example: https://lc3.cs.umanitoba.ca/)
- Copy and paste the code into the editor
- Click "Assemble"
- Switch to simulator view
- Run the program and view output

## Program Description
The program prompts the user to enter five test scores. Each score is processed and stored in memory. The program then iterates through the array to compute the minimum, maximum, and total sum. The average is calculated using a division subroutine. Each result is displayed along with its corresponding letter grade.

## Grading Scale
- 90 – 100: A
- 80 – 89: B
- 70 – 79: C
- 60 – 69: D
- 0 - 50: F

## Project Structure
- Main program handles input, looping, and output
- Subroutines:
  - READ2: Reads and converts input
  - DIV5: Calculates average
  - PRINT2: Displays numeric output
  - GRADE: Determines letter grade

## Authors
- Luis Arellano
- Michael Babeshkov
