//
//  ViewController.h
//  TextViewDemo
//
//  Created by Naveen Kumar Dungarwal on 5/18/15.
//  Copyright (c) 2015 Naveen Kumar Dungarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableArray *viewArr;
    NSInteger currentLUKIndex;
    BOOL isRecordingStart;
    
}

@property (nonatomic,strong) UIView* boxView;


@property (weak, nonatomic) IBOutlet UITextField *textview;

@end

