//
//  OneViewController.swift
//  Animation
//
//  Created by sqluo on 2016/11/15.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "第一个？？？"
        self.view.backgroundColor = UIColor.white
        
        
        let fra = self.view.frame
        let btn = UIButton(frame: CGRect(x: (fra.width - 60) / 2, y: (fra.height - 40) / 2, width: 60, height: 40))
        
        btn.backgroundColor = UIColor.red
        
        btn.setTitle("下一个", for: UIControlState())
        
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        
        
        
        
        
        
    }
    func btnAct(send: UIButton){
        
        let oneA = OneAViewController()
        
        oneA.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(oneA, animated: true)

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
