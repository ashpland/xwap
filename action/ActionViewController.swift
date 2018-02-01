//
//  ActionViewController.swift
//  action
//
//  Created by Andrew on 2018-01-30.
//  Copyright © 2018 hearthedge. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var returnText: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                    provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: {
                        (inputText, error) in
                        if let text = inputText as? String {
                            
                            self.returnText = text + "!"
                            
                            print(self.returnText)

                            let outputItem = NSExtensionItem()
                            outputItem.attributedContentText = NSAttributedString(string: self.returnText)
                            
                            
                            self.extensionContext!.completeRequest(returningItems: [outputItem], completionHandler: nil)

                            
                            
//                                - (IBAction)done:(id)sender {
//                                    NSExtensionItem *outputItem = [[NSExtensionItem alloc] init];
//                                    outputItem.attributedContentText = self.myTextView.attributedString;
//
//                                    NSArray *outputItems = @[outputItem];
//                                    [self.extensionContext completeRequestReturningItems:outputItems];
//                            }
                            
                            
                            
                            
                        }
                    })
                    break
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: [self.returnText], completionHandler: nil)
    }

}
