//
//  ViewController.swift
//  Drawings
//
//  Created by Vladislav on 6/7/20.
//  Copyright © 2020 Uladzislau Volchyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var canvasView: CoolView!
    @IBOutlet weak var pickColorButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ColorPickController {
            controller.delegate = self
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        canvasView.beganDraw(touch)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        canvasView.movedBrush(touch)
    }
}

extension ViewController: ColorPickerDelegate {
    func ColorPickerTouched(sender: ColorPicker, color: UIColor, point: CGPoint) {
        canvasView.color = color
    }
}

