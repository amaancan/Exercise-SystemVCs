//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Amaan on 2017-12-10.
//  Copyright © 2017 Amaan Khan. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController  {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image
            else {return}
        
        //applicationActivities that represents any custom services that your app might support
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil        )
        
        //On an iPad, a UIActivityViewController will be presented inside of a popover, and all popovers emanate from a particular view. Popovers are best presented from the button that triggered the presentation; in this case, sender. This line of code will have no effect on smaller iOS devices.
        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
        
    }

    @IBAction func safariButtonTapped(_ sender: UIButton) {
        
        //URL(string:) initializer returns an optional, so you'll need to unwrap it
        if let url = URL(string: "http://www.seekershub.org") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }

    }
    
    @IBAction func camerButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Image Source", message: nil,
                                                preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
            //The alert action has a property called handler, which is where you'll write the code that will be executed if the user selects that option
            print("User selected Camera action")
        })
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
            print("User selected Photo Library action")
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.popoverPresentationController?.sourceView =
        sender
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
    }
    
}

