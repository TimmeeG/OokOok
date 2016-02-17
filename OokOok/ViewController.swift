//
//  ViewController.swift
//  OokOok
//
//  Created by Tim Gallo on 1/23/16.
//  Copyright © 2016 Tim Gallo. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    
    @IBOutlet weak var programCode: UITextView!
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var dataPointerOne: UILabel!
    @IBOutlet weak var dataPointerTwo: UILabel!
    @IBOutlet weak var dataPointerThree: UILabel!
    @IBOutlet weak var dataPointerFour: UILabel!
    @IBOutlet weak var dataPointerFive: UILabel!
    @IBOutlet weak var dataPointerSix: UILabel!
    @IBOutlet weak var dataPointerSeven: UILabel!
    @IBOutlet weak var output: UILabel!

    @IBAction func runCompiler(sender: AnyObject) {
        let program = programCode.text!
        output.text = ""
        let myDataStructure = dataStructure()
        
        let lexedProgram = lexer(program)
        
        if (lexedProgram.characters.count % 8 != 0) {
            output.text = "Invalid number of characters"
            
            return
        }
        
        var braceMap = buildBraceMap(lexedProgram)
            
        var instructionPointer = 0
        var substring = ""
        while instructionPointer < lexedProgram.characters.count {
            let startIndex = lexedProgram.startIndex.advancedBy(instructionPointer)
            let endIndex = lexedProgram.startIndex.advancedBy(instructionPointer + 8)
            let range = startIndex..<endIndex
            substring = lexedProgram.substringWithRange(range)
           
            switch (substring){
            case "Ook.Ook?":
                right(myDataStructure)
            case "Ook?Ook.":
                left(myDataStructure)
            case "Ook.Ook.":
                dataInc(myDataStructure)
            case "Ook!Ook!":
                dataDec(myDataStructure)
            case "Ook!Ook.":
                dataPut(myDataStructure)
            case "Ook.Ook!":
                dataGet(myDataStructure)
            case "Ook!Ook?":
                if (myDataStructure.dataArray[myDataStructure.index] == 0) {
                    instructionPointer = braceMap[instructionPointer]!
                }
            case "Ook?Ook!":
                if (myDataStructure.dataArray[myDataStructure.index] != 0) {
                    instructionPointer = braceMap[instructionPointer]!
                }
            default:
                print("Unrecognized character")
            }
            
            instructionPointer = instructionPointer + 8
        }
        
        dataPointerOne.text = "\(myDataStructure.dataArray[0])"
        dataPointerTwo.text = "\(myDataStructure.dataArray[1])"
        dataPointerThree.text = "\(myDataStructure.dataArray[2])"
        dataPointerFour.text = "\(myDataStructure.dataArray[3])"
        dataPointerFive.text = "\(myDataStructure.dataArray[4])"
        dataPointerSix.text = "\(myDataStructure.dataArray[5])"
        dataPointerSeven.text = "\(myDataStructure.dataArray[6])"
        
    }
    
    func lexer(program: String) -> String {
      
        var solidString = program.stringByReplacingOccurrencesOfString("\n", withString: " ")
        solidString = solidString.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        return solidString
    }
    
    func buildBraceMap(program: String) -> [Int: Int]{
        var tempBraceStack: [Int] = []
        var braceMap = [Int: Int]()
        var instructionPointer = 0
        var substring = ""
        while instructionPointer < program.characters.count {
            let startIndex = program.startIndex.advancedBy(instructionPointer)
            let endIndex = program.startIndex.advancedBy(instructionPointer + 8)
            let range = startIndex..<endIndex
            substring = program.substringWithRange(range)
            
            if (substring == "Ook!Ook?"){
                tempBraceStack.append(instructionPointer)
            }
            if (substring == "Ook?Ook!"){
                let start = tempBraceStack.popLast()
                braceMap[start!] = instructionPointer
                braceMap[instructionPointer] = start
            }
            
            instructionPointer = instructionPointer + 8
        }
        
        return braceMap
    }

    func right(data: dataStructure) {
        data.index++
    }
    
    func left(data: dataStructure) {
        data.index--
    }
    
    func dataInc(data: dataStructure) {
        data.dataArray[data.index]++
    }
    
    func dataDec(data: dataStructure) {
        data.dataArray[data.index]--
    }
    
    func dataPut(data: dataStructure) {
        //output.text = output.text! + "\(data.dataArray[data.index])"
        output.text = output.text! + String(Character(UnicodeScalar(data.dataArray[data.index])))
    }
    
    func dataGet(data: dataStructure) -> dataStructure {
        let alert = UIAlertController(title: "User Input", message: "Enter an integer!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(nil)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertView) in
            
            let alertText = alert.textFields![0].text!
            data.dataArray[data.index] = Int(alertText)!
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        return data
    }
    
    class dataStructure{
        var dataArray: [Int] = [0,0,0,0,0,0,0]
        var index = 0
    }
}

