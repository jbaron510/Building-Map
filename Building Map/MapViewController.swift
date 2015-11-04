//
//  MapViewController.swift
//  Building Map
//
//  Created by Jon Baron on 10/28/15.
//  Copyright © 2015 Walmart. All rights reserved.
//
// m34 = 220 and rotation around x of -45 is a good intial value
import UIKit

class MapViewController: UIViewController {

    var m34Var: CGFloat!
    var rotationVar: CGFloat!
    var anchorXVar: CGFloat!
    var anchorYVar: CGFloat!
    var anchorZVar: CGFloat!

    var transform = CATransform3DIdentity
    var headingTransform = CATransform3DIdentity
    
    @IBOutlet weak var mapImageView: UIImageView!
    
    @IBAction func slideM34(sender: UISlider) {
        
        m34Var = CGFloat(sender.value)
        print("m34 \(m34Var)")
    }
    
    @IBAction func slideRotation(sender: UISlider) {
        // var headingTransform = CATransform3DIdentity
        
        rotationVar = CGFloat(sender.value) - 45
        print("heading \(rotationVar)")
        headingTransform.m34 = 1.0 / 220
        //headingTransform = CATransform3DRotate(headingTransform, CGFloat((rotationVar - 45) * CGFloat(M_PI) / 180), 1, 0, 0)
        // mapImageView.layer.transform = CATransform3DConcat(headingTransform, transform)
        // headingTransform = CATransform3DRotate(headingTransform, CGFloat((-rotationVar - 45) * CGFloat(M_PI) / 180), abs((180 - rotationVar)) / 360, 1 - abs((180 - rotationVar)) / 180, 1 - abs((180 - rotationVar)) / 180)
        headingTransform = CATransform3DRotate(headingTransform, CGFloat(rotationVar * CGFloat(M_PI) / 180), 50, 1, 1)
        mapImageView.layer.transform = headingTransform
        
    }
    
    @IBAction func slideAnchorX(sender: UISlider) {
        anchorXVar = CGFloat(sender.value)
        print("anchor X \(anchorXVar), anchor Y \(anchorYVar), anchor Z \(anchorZVar), ")
        
        headingTransform = CATransform3DRotate(headingTransform, CGFloat((rotationVar - 45) * CGFloat(M_PI) / 180), anchorXVar, anchorYVar, anchorZVar)
        mapImageView.layer.transform = headingTransform
        

    }
    
    
    @IBAction func slideAnchorY(sender: UISlider) {
        anchorYVar = CGFloat(sender.value)
        print("anchor X \(anchorXVar), anchor Y \(anchorYVar), anchor Z \(anchorZVar), ")
        
        headingTransform = CATransform3DRotate(headingTransform, CGFloat((rotationVar - 45) * CGFloat(M_PI) / 180), anchorXVar, anchorYVar, anchorZVar)
        mapImageView.layer.transform = headingTransform
       
        

    }
    
    @IBAction func slideAnchorZ(sender: UISlider) {
        
        anchorZVar = CGFloat(sender.value)
        print("anchor X \(anchorXVar), anchor Y \(anchorYVar), anchor Z \(anchorZVar), ")
        
        headingTransform = CATransform3DRotate(headingTransform, CGFloat((rotationVar - 45) * CGFloat(M_PI) / 180), anchorXVar, anchorYVar, anchorZVar)
        mapImageView.layer.transform = headingTransform
        

    }
    
    @IBAction func onTapButton(sender: UIButton) {
        
        transform.m34 = 1.0 / m34Var
        transform = CATransform3DRotate(transform, CGFloat(rotationVar * CGFloat(M_PI) / 180), 1, 0, 0)
        mapImageView.layer.transform = transform
        
        
    }
    
    func skewMap(imageView: UIImageView) {
        var initialTransform = CATransform3DIdentity
        
        initialTransform.m34 = 1.0 / 220
        initialTransform = CATransform3DRotate(initialTransform, CGFloat(-45 * CGFloat(M_PI) / 180), 1, 0, 0)
        imageView.layer.transform = initialTransform
        transform = initialTransform

    }
    
    // inject an image asset into a UiImageView. Pass this function the name of the image view, the name of the building, and the floor. Building name is a string and will need to be in quotes.
    //    Accepted Building names:
    //    SB850C = San Bruno, 850, Cherry
    //    SV860C = Sunnyvale, 860 California
    func pickMap(imageView: UIImageView, buildingName: NSString, floor: Int) {

        print(" \(buildingName) \(floor)")

        //assign image assets based on building, based on floor
        if buildingName == "SB850C" {
            if floor == 1 {
                imageView.image = UIImage(named: "SB850C1")
            } else if floor == 4 {
                imageView.image = UIImage(named: "SB850C4")
            }
        } else if buildingName == "SV860C" {
            if floor == 1 {
                imageView.image = UIImage(named: "SV860C1")
            }
        }
        skewMap(imageView)
        
        
        
    }
    
    func rotateBasedOnHeading(imageView: UIImageView) {
        // rotate the image based on heading
        // imageView = CGAffineTransformMakeRotation(heading)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var m34Var = 1
//        var rotationVar = 0
        var anchorXVar = 1.0
        var anchorYVar = 0.0
        
        
        var anchorZVar = 0.0
        print("anchor X \(anchorXVar), anchor Y \(anchorYVar), anchor Z \(anchorZVar), ")
        pickMap(mapImageView, buildingName: "SB850C", floor: 4)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
