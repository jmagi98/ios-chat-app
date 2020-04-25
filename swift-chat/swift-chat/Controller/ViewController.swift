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
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func onSend(_ sender: Any) {
        var text: String? =  messageField.text
        print(text)
        messageField.text = ""
    }
    
    
    func addHandlers() {
        // Our socket handlers go here
        self.manager.defaultSocket.onAny{
            print("Got event: \($0.event), with items: \($0.items)")
        }
        
        self.manager.defaultSocket.on("test-message") {[weak self] data, ack in
            print(data)
        }

    }
}

