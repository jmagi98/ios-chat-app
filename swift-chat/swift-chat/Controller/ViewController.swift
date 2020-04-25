//
//  ViewController.swift
//  swift-chat
//
//  Created by Jack Maginnes on 4/25/20.
//  Copyright © 2020 Jack Maginnes. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        sockets()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func onSend(_ sender: Any) {
        var text: String? =  messageField.text
        print(text)
        messageField.text = ""
    }
    
    func sockets() {
        let manager = SocketManager(socketURL: URL(string: "http://localhost:3002")!, config: [.log(true), .compress])
        let socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
    }
    
    
    
}

