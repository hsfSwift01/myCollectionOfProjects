# CCPCountdownDeme

实现倒计时功能

##效果图

![Image text](https://github.com/IMCCP/CCPCountdownDemo/blob/master/CCPCountdownDemo/ccpbutton.gif)

## 使用指南

####1.自定义Button 继承自CCPCountDownButton

####2.设置button的属性

  //设置button的title的原始显示颜色,默认的是红色
  
  self.CCPCountDownBtn.originalColor = [UIColor purpleColor];
  
  //设置button的title的倒计时时显示颜色,默认的是蓝色
  
  self.CCPCountDownBtn.processColor = [UIColor greenColor];
  
   //设置倒计时的时间,默认是60s
   
  self.CCPCountDownBtn.durationOfCountDown = 10;


