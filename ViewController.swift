//
//  ViewController.swift
//  计时器
//
//  Created by zx5833 on 16/5/5.
//  Copyright © 2016年 zx5833. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var  ctimer:UIDatePicker!
    var btnstart:UIButton!
    
    var leftTime:Int = 180
    var alertView:UIAlertView!
    
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ctimer = UIDatePicker(frame:CGRectMake(0.0, 120.0, 200.0, 200.0))
        self.ctimer.datePickerMode = UIDatePickerMode.CountDownTimer;
        
        //必须为 60 的整数倍，比如设置为100，值自动变为 60
        
        dispatch_async(dispatch_get_main_queue(), {
            self.ctimer.countDownDuration = NSTimeInterval(self.leftTime);
        })
        ctimer.addTarget(self, action: "timerChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(ctimer)
        
        btnstart =  UIButton(type: .System)
        btnstart.frame = CGRect(x:100, y:400, width:100, height:100);
        btnstart.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btnstart.setTitleColor(UIColor.greenColor(), forState:UIControlState.Disabled)
        btnstart.setTitle("开始", forState:UIControlState.Normal)
        btnstart.setTitle("倒计时中", forState:UIControlState.Disabled)
        
        btnstart.clipsToBounds = true;
        btnstart.layer.cornerRadius = 5;
        btnstart.addTarget(self, action:"startClicked:",
            forControlEvents:UIControlEvents.TouchUpInside)
        
        self.view.addSubview(btnstart)
    }
    
    func timerChanged()
    {
        print("您选择倒计时间为：\(self.ctimer.countDownDuration)")
    }
    
    /**
    *开始倒计时按钮点击
    */
    func startClicked(sender:UIButton)
    {
        self.btnstart.enabled = false;
        
        // 获取该倒计时器的剩余时间
        leftTime = Int(self.ctimer.countDownDuration);
        // 禁用UIDatePicker控件和按钮
        self.ctimer.enabled = false;
        
        // 创建一个UIAlertView对象（警告框），并确认，倒计时开始
        alertView = UIAlertView()
        alertView.title = "到计时开始"
        alertView.message = "倒计时开始，还有 \(leftTime) 秒..."
        alertView.addButtonWithTitle("确定")
        // 显示UIAlertView组件
        alertView.show()
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1),
            target:self,selector:Selector("tickDown"),
            userInfo:nil,repeats:true)
    }
    
    /**
    *计时器每秒触发事件
    **/
    func tickDown()
    {
        alertView.message = "倒计时开始，还有 \(leftTime) 秒..."
        // 将剩余时间减少1秒
        leftTime -= 1;
        // 修改UIDatePicker的剩余时间
        self.ctimer.countDownDuration = NSTimeInterval(leftTime);
        print(leftTime)
        // 如果剩余时间小于等于0
        if(leftTime <= 0)
        {
            // 取消定时器
            timer.invalidate();
            // 启用UIDatePicker控件和按钮
            self.ctimer.enabled = true;
            self.btnstart.enabled = true;
            alertView.message = "时间到！"
        }
    }
}




