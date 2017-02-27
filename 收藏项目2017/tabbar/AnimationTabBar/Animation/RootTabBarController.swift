//
//  RootTabBarController.swift
//  Animation
//
//  Created by sqluo on 2016/11/15.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit


class RootTabBarController: UITabBarController {
    //tabbar的高度
    fileprivate let myHeight: CGFloat = 64
    //存放子视图
    fileprivate var viewArray = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //清除顶部线条
        self.clearTabBarTopLine()
        
        //添加顶部的线条以及圆弧
        let bgV = LineVeiw(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: myHeight))
        bgV.backgroundColor = UIColor.groupTableViewBackground
        self.tabBar.addSubview(bgV)
        
        //创建子控制器
        self.creatSubViewCtrs()
    }
    
    //MARK:清除顶部线条
    fileprivate func clearTabBarTopLine(){
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.clear.cgColor)
        
        context?.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.backgroundImage = img
        self.tabBar.shadowImage = img
    }
    
    
    //在这里修改
    override func viewWillLayoutSubviews() {
        //重新设置tabbar 的高度
        var frame = self.tabBar.frame
        frame.size.height = myHeight
        frame.origin.y = self.view.frame.size.height - myHeight
        self.tabBar.frame = frame
        self.tabBar.barStyle = .default
        
        //设置图片偏移，因为加高了tabbar
        for i in 0..<self.tabBar.items!.count {
            let itm = self.tabBar.items![i]
            if i != 2 {
                itm.imageInsets = UIEdgeInsets(top: myHeight - 49 - 5, left: 0, bottom: -(myHeight - 49 - 5), right: 0)
            }else{
                itm.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
  
            }
            
        }
 
    }
    
    
    override func viewDidLayoutSubviews() {
        
        self.viewArray.removeAll()
        
        for index in 0..<self.tabBar.subviews.count {

            let view = self.tabBar.subviews[index]
            self.viewArray.append(view)
        }
        
        for i in 0..<self.viewArray.count {
            
            let v = self.viewArray[i]
            v.layer.removeAllAnimations()
            
            if self.viewArray.count > 5 { //如果添加了其他视图，则会多
                
                if i == self.viewArray.count - 3 {
                    self.animation(v)
                }
            }else{
                
                if i == 2 {
                    self.animation(v)
                }
            }
        }
        
    }
    
    //MARK:动画
    fileprivate func animation(_ view: UIView){
        
        let layer = view.layer
        layer.cornerRadius = 5.0
        
        //2.写剧本
        let scaleAnimate = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimate.fromValue = 0.95
        scaleAnimate.toValue = 1.0
        scaleAnimate.autoreverses = true
        scaleAnimate.repeatCount = MAXFLOAT
        scaleAnimate.duration = 0.8
        
        //第二个剧本
        let opaqueAnimate = CABasicAnimation(keyPath: "opacity")
        opaqueAnimate.fromValue = 0.7
        opaqueAnimate.toValue = 1
        opaqueAnimate.autoreverses = true
        opaqueAnimate.repeatCount = MAXFLOAT
        opaqueAnimate.duration = 0.8
        
        //把剧本交给演员开始动画
        layer.add(scaleAnimate, forKey: "scaleAnimate")
        layer.add(opaqueAnimate, forKey: "opacityAnimate")
        
        
        
    }
   
    
    
    fileprivate func creatSubViewCtrs(){
        
        //1.
        let oneVC = OneViewController()
        let one = UINavigationController(rootViewController: oneVC)
        one.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        one.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        
        
        one.tabBarItem = UITabBarItem(title: "第一", image: UIImage(named: "homeA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homeL")?.withRenderingMode(.alwaysOriginal))
        
        
        
        //2.
        let towVC = TowViewController()
        let tow = UINavigationController(rootViewController: towVC)
        tow.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        tow.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        tow.tabBarItem = UITabBarItem(title: "第二", image: UIImage(named: "reportA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "reportL")?.withRenderingMode(.alwaysOriginal))
        
        //中间
        let midVC = MidViewController()
        let mid = UINavigationController(rootViewController: midVC)
        mid.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        mid.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        mid.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "baseAct")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "baseAct")?.withRenderingMode(.alwaysOriginal))
 
        //3.
        let threeVC = ThreeViewController()
        let three = UINavigationController(rootViewController: threeVC)
        three.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        three.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        three.tabBarItem = UITabBarItem(title: "第三", image: UIImage(named: "messageA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "messageL")?.withRenderingMode(.alwaysOriginal))
        //4.
        let fourVC = FourViewController()
        let four = UINavigationController(rootViewController: fourVC)
        four.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        four.navigationBar.barTintColor = UIColor(red: 246/255.0, green: 93/255.0, blue: 34/255.0, alpha: 1)
        four.tabBarItem = UITabBarItem(title: "第亖", image: UIImage(named: "shopA")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "shopL")?.withRenderingMode(.alwaysOriginal))
        //添加到控制器数组
        let tabArray = [one,tow,mid,three,four]
        self.viewControllers = tabArray
        //设置文字的颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
