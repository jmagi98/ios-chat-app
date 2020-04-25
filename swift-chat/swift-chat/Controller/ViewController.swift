//
//  ViewController.swift
//  swift-chat
//
//  Created by Jack Maginnes on 4/25/20.
//  Copyright © 2020 Jack Maginnes. All rights reserved.
//

import UIKit
import SocketIO
import Foundation
class ViewController: UIViewController {
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3002")!, config: [.log(true), .compress])
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.addHandlers()
        self.manager.defaultSocket.connect()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
    }
    
    
    

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var messages: UITextView!
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -350// Move view 150 points upward
        messages.frame.origin.y += 300
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @IBAction func onSend(_ sender: Any) {
        var text: String? =  messageField.text
        print(text)
        messageField.text = ""
        sendMessage(message: text!)
        displayMessage(message: text!)
        messageField.endEditing(true)
    }
    
    
    func displayMessage(message: String) {
        messages.text += message + "\n"
        
    }
    
    
    func sendMessage(message: String) {
        self.manager.defaultSocket.emit("new-message", message)
    }
    
    func addHandlers() {
        // Our socket handlers go here
        self.manager.defaultSocket.onAny{
            print("Got event: \($0.event), with items: \($0.items)")
        }
        
        self.manager.defaultSocket.on("test-message") {[weak self] data, ack in
            print(data)
        }
        
        self.manager.defaultSocket.on("incoming-message") {[weak self] data, ack in
            let message: String = String(describing: data)
            self!.displayMessage(message: message.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""))
        }
    }
    
    
    
    
}

