//
//  TowViewController.swift
//  Animation
//
//  Created by sqluo on 2016/11/15.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class TowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "这也叫动画？"
        
        self.animation1()
        
        self.animation2()
        
    }
    
    
    
    
    func animation1(){
        
        let imgView = UIImageView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        
        imgView.image = UIImage(named: "tencent.png")
        
        self.view.addSubview(imgView)
        
        
        let layer = imgView.layer
        
        layer.cornerRadius = 5.0
        
        let scaleAnimate = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 0.8
        scaleAnimate.toValue = 1.5
        scaleAnimate.autoreverses = true
        scaleAnimate.repeatCount = 1
        scaleAnimate.duration = 1.5
        
        let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
        opaqueAnimate.fromValue = 0.1
        opaqueAnimate.toValue = 1
        //是否自动反动画
        opaqueAnimate.autoreverses = true
        //循环次数
        opaqueAnimate.repeatCount = 1
        opaqueAnimate.duration = 1.5
        
        
        
        let rotation = CABasicAnimation(keyPath: "rotation.z")
        rotation.fromValue = 0
        rotation.toValue = M_PI
        rotation.autoreverses = false
        rotation.repeatCount = MAXFLOAT
        
        rotation.duration = 1
        
        
        
        layer.add(scaleAnimate, forKey: "scaleAnimate")
        layer.add(opaqueAnimate, forKey: "opacityAnimate")
        
        layer.add(rotation, forKey: "rotationAnimate")
        
    }
    
    
    func animation2(){
        
        //创建一个imageview视图
        let imgView = UIImageView(image: UIImage(named: "tencent.png"))
        imgView.frame = CGRect(x: 200, y: 200, width: 40, height: 40)
        self.view.addSubview(imgView)
        
        //1.选定角色
        let layer = imgView.layer
        layer.cornerRadius = 5.0
        
        //2.写剧本
        let keyAnimate = CAKeyframeAnimation(keyPath: "position")
        //3.设定关键帧
        let value0 = NSValue(cgPoint: layer.position)
        
        let value1 = NSValue(cgPoint: CGPoint(x: layer.position.x, y: layer.position.y + 200))
        let value2 = NSValue(cgPoint: CGPoint(x: layer.position.x - 150, y: layer.position.y + 200))
        let value3 = NSValue(cgPoint: CGPoint(x: layer.position.x - 150, y: layer.position.y))
        let value4 = NSValue(cgPoint: layer.position)
        //速度曲线
        let tf0 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let tf1 = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        let tf2 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        let tf3 = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        keyAnimate.timingFunctions = [tf0, tf1, tf2, tf3]
        //每段执行的时间
        //        keyAnimate.keyTimes = [0.5, 2.0, 3, 2, 4]
        
        keyAnimate.values = [value0, value1, value2, value3, value4]
        keyAnimate.autoreverses = false
        keyAnimate.repeatCount = MAXFLOAT
        keyAnimate.duration = 6.0
        
        layer.add(keyAnimate, forKey: "keyAnimate")
        
   
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
