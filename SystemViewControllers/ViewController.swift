//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Amaan on 2017-12-10.
//  Copyright © 2017 Amaan Khan. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    //Question: Why do my outlets and buttons work even though the circle is not filled???

    
    //MARK: - SHARE BUTTON TAPPED
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //applicationActivities that represents any custom services that your app might support

        activityController.popoverPresentationController?.sourceView = sender
        //On an iPad, a UIActivityViewController will be presented inside of a popover, and all popovers emanate from a particular view. Popovers are best presented from the button that triggered the presentation; in this case, sender. This line of code will have no effect on smaller iOS devices.
        
        present(activityController, animated: true, completion: nil)
    }

    
    //MARK: - SAFARI BUTTON TAPPED
    //Question: Can I pass in a value to be input into a field in the website???
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "http://www.seekershub.org") {
        //URL(string:) initializer returns an optional, so you'll need to unwrap it
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - CAMERA BUTTON TAPPED
    @IBAction func camerButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // Check to see if the camera and photo library are available source types. If one or both are supported, create alert actions accordingly.
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                //The alert action has a property called handler; code will be executed if the user selects this option.
                
                imagePicker.sourceType = .camera // Setting the camera as the source of the imagePicker
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }

        alertController.popoverPresentationController?.sourceView = sender
        //Set the sourceView property so that the popover presents in the proper location on an iPad.
        
        present(alertController, animated: true, completion: nil)
        
        //MARK: - ADD INFO.PLIST KEYS TO REQUEST USER PERMISSION FOR ACCESS TO PRIVATE DATA
        //Changed the Info.plist to contain an NSPhotoLibraryUsageDescription and NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Need a way to grab the selected photo and bring it into the app. Do this by implementing the delegate method imagePickerController(_:didFinishPickingMediaWithInfo:). This method tells the delegate that the user has picked a photo (or other media), AND includes the photo in the info dictionary.
        print("didFinishingPicking got called.")
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //checking if the key's value is actually an image
            //as? has a question mark becuase the whole statement is a question that returns a boolean for the 'if'
            // Use the key UIImagePickerControllerOriginalImage to capture the image that the user selected.
            imageView.contentMode = .scaleAspectFit
            imageView.image = selectedImage
           // print("Image was selected successfully and saved into variable")
            dismiss(animated: true, completion: nil)
//            print("Dismissed imagePickerController successfully")
        }
    }
    
    
    //MARK: - EMAIL BUTTON TAPPED
    @IBAction func emailButtonTapped(_ sender: UIButton) {
    }
}
