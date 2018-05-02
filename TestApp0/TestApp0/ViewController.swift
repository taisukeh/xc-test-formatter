//
//  ViewController.swift
//  TestApp0
//
//  Created by 堀泰祐 on 2018/04/24.
//  Copyright © 2018 taisukeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var i = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onChangeColor(_ sender: Any) {
    if i % 3 == 0 {
      view.backgroundColor = UIColor.green
    } else if i % 3 == 1 {
      view.backgroundColor = UIColor.blue
    } else if i % 3 == 2 {
      view.backgroundColor = UIColor.cyan
    }
    
    i += 1
  }
  
}

