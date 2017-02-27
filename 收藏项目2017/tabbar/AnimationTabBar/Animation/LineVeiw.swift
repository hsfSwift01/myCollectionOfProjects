//
//  LineVeiw.swift
//  Animation
//
//  Created by sqluo on 2016/11/16.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class LineVeiw: UIView {


    //线条应该 距离底部49
    var lineY: CGFloat!
    
    //圆半径 为 视图高度的一半
    var radiu: CGFloat!

    //画图的宽度
    var lineWidth: CGFloat = 0.5
    
    override func draw(_ rect: CGRect) {
        
        lineY = rect.height - self.lineWidth - 49
        
        radiu = (rect.height - self.lineWidth * 2) / 2.0

        
        let color = UIColor.red
        color.set()
        
        //1.左边线条
        let path = UIBezierPath()
        path.lineWidth = self.lineWidth
        
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        //起点
        path.move(to: CGPoint(x: 0, y: lineY))
        
        //圆心到 左右横线的垂直距离
        let toTop = radiu - lineY + lineWidth
        //勾股定理
        let all = pow(radiu, 2) - pow(toTop, 2)
        
        //对边长（有两个，所以 * 2）
        let x2 = sqrt(all) * 2
        
        //线条宽度（视图宽度减去 圆 所占的 宽度 ，除以2 得到 一边的宽度）
        let line1W = (rect.width - x2) / 2
        //圆左边点
        let leftPoint = CGPoint(x: line1W, y: lineY)
        
        path.addLine(to: leftPoint)
        path.close()
        path.stroke()

        //2.右边线条
        let path1 = UIBezierPath()
        path1.lineWidth = self.lineWidth
        path1.lineCapStyle = .round
        path1.lineJoinStyle = .round
        
        let rX = rect.width - line1W
        
        //圆右边点
        let rightPoint = CGPoint(x: rX, y: lineY)
        path1.move(to: rightPoint)
        path1.addLine(to: CGPoint(x: rect.width, y: lineY))
        path1.close()
        path1.stroke()
        
        //画弧形
        
        //3.弧度
        let yyy2 = acos(toTop / radiu)
        //clockwise 是 true 则为顺时针，为 false 则是逆时针
        let centerPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let patht3 = UIBezierPath(arcCenter: centerPoint, radius: radiu, startAngle: -yyy2 - CGFloat(M_PI_2), endAngle: yyy2 - CGFloat(M_PI_2), clockwise: true)
        
        patht3.lineWidth = self.lineWidth
        
        patht3.stroke()
        
        
        
        
        
        //镂空，去除上边白色部分

        let ppp = UIBezierPath(rect: CGRect(x: 0, y: lineY - self.lineWidth, width: rect.width, height: rect.height - lineY))

        ppp.append(UIBezierPath(roundedRect: CGRect(x: (rect.width - rect.height) / 2, y: 0, width: rect.height, height: rect.height), cornerRadius: radiu))
  
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = ppp.cgPath
        
        
        self.layer.mask = shapeLayer
        
    }
 
    
    
    
    

}
