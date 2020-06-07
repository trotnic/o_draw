//
//  ColorPickController.swift
//  Drawings
//
//  Created by Vladislav on 6/7/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

import UIKit

class ColorPickController: UIViewController {

    var delegate: ColorPickerDelegate?
    
    @IBOutlet weak var cpView: ColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        cpView.delegate = delegate
        
        
    }
}
