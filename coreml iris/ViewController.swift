//
//  ViewController.swift
//

import UIKit
import CoreML

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var sepalLengthTextField: UITextField!
    @IBOutlet weak var sepalWidthTextField: UITextField!
    @IBOutlet weak var petalLengthTextField: UITextField!
    @IBOutlet weak var petalWidthTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var setosaImage: UIImageView!
    @IBOutlet weak var versicolorImage: UIImageView!
    @IBOutlet weak var virginicaImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: Actions
    @IBAction func predict(_ sender: UIButton) {
        let sepalLength = Double(sepalLengthTextField.text!)
        let sepalWidth = Double(sepalWidthTextField.text!)
        let petalLength = Double(petalLengthTextField.text!)
        let petalWidth = Double(petalWidthTextField.text!)
        
        if (sepalLength == nil || sepalWidth == nil || petalLength == nil || petalWidth == nil){
            outputLabel.text = "Enter valid values"
        }
        else{
            do {
                let prediction = try iris_logistic_regression().prediction(sepal_length__cm_: sepalLength!, sepal_width__cm_: sepalWidth!, petal_length__cm_: petalLength!, petal_width__cm_: petalWidth!)
                print (prediction.class_)
                print (prediction.classProbability)
                
                setosaImage.isHidden = true
                versicolorImage.isHidden = true
                virginicaImage.isHidden = true

                var flowerType : String
                if (prediction.class_ == 0){
                    flowerType = "setosa"
                    versicolorImage.isHidden = false
                }
                else if(prediction.class_ == 1){
                    flowerType = "versicolor"
                    setosaImage.isHidden = false
                }
                else{
                    flowerType = "virginica"
                    virginicaImage.isHidden = false
                }
                outputLabel.text = String(format: "Its a %@", flowerType)
            }
            catch{
                outputLabel.text = "Error"
            }
        }
    }
}

