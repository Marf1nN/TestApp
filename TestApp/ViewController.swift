//
//  ViewController.swift
//  TestApp
//
//  Created by Vladyslav Filippov on 28.03.17.
//  Copyright © 2017 Vladyslav Filippov. All rights reserved.
//

import UIKit
import ImageSlideshow
import AMTagListView
import Social

class ViewController: UIViewController , UITextFieldDelegate  {
    
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var labelReceprt: UILabel!
    @IBOutlet weak var tagListView: AMTagListView!
    
     let localSource = [ImageSource(imageString: "pz1")!, ImageSource(imageString: "piz2")!, ImageSource(imageString: "piz3")!,ImageSource(imageString: "piz4")!]

    @IBOutlet weak var labelIngridient: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tagList(tagListView, didRemove: textFiled.text! as! AMTag)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        // textFiled 
        
        textFiled.layer.borderColor = UIColor.red.cgColor
        textFiled.layer.borderWidth = 2.0
        textFiled.layer.cornerRadius = 15
        textFiled.delegate = self
        AMTagView.appearance().tagLength = 5
     //   AMTagView.appearance().textPadding = CGPoint(dictionaryRepresentation: 14 as! CFDictionary)!
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 12)
        AMTagView.appearance().tagColor = UIColor.red
        
        tagListView.addTag("my tag")
        
        
        // end
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
       scrollView.contentSize.height = 1000
        
      labelReceprt.layer.borderWidth = 2.0
        
      labelReceprt.layer.borderColor = UIColor.red.cgColor
      labelIngridient.text = "Інгридіент1,Інгридіент2,Інгридіент3,Інгридіент3,Інгридіент3,Інгридіент4,Інгридіент5,Інгридіет6"
        
        
        
        //Slide SHow
        
        slideShow.layer.borderWidth = 1.5
        slideShow.layer.borderColor = UIColor.red.cgColor
        slideShow.backgroundColor = UIColor.white
        slideShow.slideshowInterval = 5.0
        slideShow.pageControlPosition = PageControlPosition.underScrollView
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideShow.pageControl.pageIndicatorTintColor = UIColor.black
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideShow.currentPageChanged = { page in
            print("current page:", page)
        }
        slideShow.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
        slideShow.addGestureRecognizer(recognizer)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func didTap() {
        slideShow.presentFullScreenController(from: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFiled.resignFirstResponder()
        tagListView.removeTag(tagListView)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagListView.addTag(textField.text)
            textField.text = ""
        
        return false;
    }
    
    @IBAction func shareToFaceBook(_ sender: Any) {
        
        var shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("Це моя страва")
        shareToFacebook.add(UIImage(named: "piz2"))
        
        
        self.present(shareToFacebook, animated: true, completion: nil)
        
        }
    
    @IBAction func shareToTwitter(_ sender: Any) {
        
        var shareToTwitter : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareToTwitter.setInitialText("Це моя страва")
        shareToTwitter.add(UIImage(named: "piz2"))
        
        self.present(shareToTwitter, animated: true, completion: nil)
        
    }
    
    @IBAction func shareWithFriends(_ sender: Any) {
        
        let activityVS = UIActivityViewController(activityItems: [self.slideShow.images], applicationActivities: nil)
        activityVS.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVS, animated: true, completion: nil)
        
        
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    
       }
    func tagList(_ tagListView: AMTagListView, didRemove tag: AMTag) {
        
        tagListView.removeTag(tagListView)
        
    }

}
