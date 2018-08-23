//
//  ViewController.swift
//  on-the-road-again
//
//  Created by Pavel Krayzel on 22/08/2018.
//  Copyright © 2018 Edonon Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let max = "🏆"
    let firstPlace = "🥇"
    let secondPlace = "🥈"
    let thirdPlace = "🥉"
    var carColours : Array = ["car_black.png", "car_blue.png", "car_green.png",
                              "car_lightgray.png", "car_pink.png", "car_red.png",
                              "car_white.png", "car_yellow.png"]
    var carColoursDimensions : Dictionary = ["car_black.png": 160, "car_blue.png": 183, "car_green.png": 180, "car_lightgray.png":156,
                                   "car_pink.png": 198, "car_red.png": 184, "car_white.png": 182, "car_yellow.png": 154]
    var usedColours = Array([])
    var foundColours = Array([])
    var notfoundColours = Array([])
    var imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNextImage()
        self.view.addSubview(imageView)
        someImageViewConstraints()
    }
    
    // do not forget the `.isActive = true` after every constraint
    func someImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addResultLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: CGFloat(100))
        
//        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        switch foundColours.count {
        case (carColoursDimensions.count-1)...:
            label.text = max
        case 6...7:
            label.text = firstPlace
        case 4...5:
            label.text = secondPlace
        default:
            label.text = thirdPlace
        }
        
        self.view.addSubview(label)
    }
    
    @IBAction func seenCar(sender : UIButton) {
        if carColours.count > 0 {
            foundColours.append(usedColours[usedColours.count-1])
            showNextImage()
        } else {
            addResultLabel()
            self.imageView.removeFromSuperview()
        }
    }
    
    @IBAction func skipedCar(sender : UIButton) {
        if carColours.count > 0 {
            foundColours.append(usedColours[usedColours.count-1])
            showNextImage()
        } else {
            addResultLabel()
            self.imageView.removeFromSuperview()
        }
    }
    
    func getNextRandomColour() -> String {
        if carColours.count == 0 {
            return ""
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(carColours.count)))
        let name = self.carColours[randomIndex]
        self.carColours.remove(at: randomIndex)
        usedColours.append(name)
        return name
    }
    
    func showNextImage() {
        let image_name = getNextRandomColour()
        imageView.image = UIImage(named: image_name)
        let height = carColoursDimensions[image_name]
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(height!)).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

