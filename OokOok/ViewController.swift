//
//  ViewController.swift
//  OokOok
//
//  Created by Tim Gallo on 1/23/16.
//  Copyright © 2016 Tim Gallo. All rights reserved.
//

import UIKit

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

    @IBAction func runCompiler(sender: AnyObject) {
        let program = programCode.text!
        
        var myDataStructure = dataStructure()
        
        dataPointerOne.text = "0"
        dataPointerTwo.text = "1"
        dataPointerThree.text = "2"
        dataPointerFour.text = "3"
        dataPointerFive.text = "4"
        dataPointerSix.text = "5"
        dataPointerSeven.text = "6"
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func right(data: dataStructure) -> dataStructure {
        data.index++
        
        return data
    }
    
    func left(data: dataStructure) -> dataStructure {
        data.index--
        
        return data
    }
    
    func dataInc(data: dataStructure) -> dataStructure {
        data.dataArray[data.index]++
        
        return data
    }
    
    func dataDec(data: dataStructure) -> dataStructure {
        data.dataArray[data.index]--
        
        return data
    }
    
    func dataPut(data: dataStructure) -> Int {
        return data.dataArray[data.index]
    }
    
    func dataGet(data: dataStructure) -> dataStructure {
        //TODO use UIAlertView to collect input from user
        data.dataArray[data.index] = 0
        
        return data
    }
    
    class dataStructure{
        internal var dataArray = [Int]()
        internal var index = 0
    }
}

