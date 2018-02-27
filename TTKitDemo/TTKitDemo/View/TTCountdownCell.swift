//
//  TTCountdownCell.swift
//  TTKitDemo
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 shang. All rights reserved.
//

import UIKit

class TTCountdownCell: BaseTouchTableViewCell {
    
    let countLabel = CountdownLabel()
    @objc var model: CellModel? {
        
        willSet{
            let date = NSDate.init(timeIntervalSince1970:TimeInterval(newValue?.date ?? 0) )
            countLabel.setCountDownDate(fromDate:NSDate() , targetDate: date)
            //            countLabel.animationType = .Evaporate;
            countLabel.start()
            if countLabel.counting {
                countLabel.textColor = UIColor.black
            }else{
                countLabel.textColor = UIColor.gray
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        countLabel.frame = CGRect.init(x: 20, y: 0, width: 200, height: 44);
        self.contentView.addSubview(countLabel)
        countLabel.font = UIFont.systemFont(ofSize: 12);
        countLabel.timeFormat = "dd天HH小时mm分钟ss秒"
        countLabel.completion = { [unowned self] ()  in
            self.countLabel.text = "结束"
            self.countLabel.textColor = UIColor.gray
            self.countLabel.finished = true
            return nil
        } 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
