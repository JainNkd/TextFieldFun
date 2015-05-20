//
//  ViewController.m
//  TextViewDemo
//
//  Created by Naveen Kumar Dungarwal on 5/18/15.
//  Copyright (c) 2015 Naveen Kumar Dungarwal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Text Box Fun";
    viewArr = [[NSMutableArray alloc]init];
    
    CGFloat height = 100,width = 0;
    for(int i=0; i<10; i++)
    {
        if(i % 4 == 0)
        {   width = 0;
            height += 80+10;
        }
        else
        {
            width +=80;
        }
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(width,height,80,80)];
        [view.layer setBorderColor:[UIColor redColor].CGColor];
        [view.layer setBorderWidth:2.0];
        [view.layer setMasksToBounds:YES];
        
        
        view.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:view];
        view.hidden = YES;
        [viewArr addObject:view];
    }
    
    
    //    self.boxView = [[UIView alloc]initWithFrame:CGRectMake(0,300,100,100)];
    //    //    self.boxView.hidden = YES;
    //    self.boxView.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:self.boxView];
    
}

//Text view delgate Methods
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"textView...%@...text..%@..",textView.text,text);
    
    NSMutableArray *array;
    NSString *textViewStr = [self.textview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(text.length == 0)
    {
        if ([textViewStr length] > 0) {
            textViewStr = [textViewStr substringToIndex:[textViewStr length] - 1];
        } else {
            //no characters to delete... attempting to do so will result in a crash
        }
    }
    
    if(textViewStr.length>0){
        array = (NSMutableArray*)[textViewStr componentsSeparatedByString:@" "];
        if([array count]>1)
        [array removeObject:@""];
    }
    
    if ( [text isEqualToString:@""]) {//When detect backspace when have one character.
        if(isRecordingStart){
            return NO;
        }
        else{
            [self resetLUK:[array count]];
            currentLUKIndex = [array count];
        }
    }
    else{
        if([text isEqualToString:@" "])//When user enter one character.
        {
            NSLog(@"textView...%@..",textViewStr);
            if(textViewStr.length>0){
                
                if([array count] > 0 && [array count] < 11){
                    if(currentLUKIndex != [array count]){
                        [self animateView:[array count]];
                        currentLUKIndex = [array count];
                    }
                }
                
                if([array count]>9)
                {
                    //            message = @"You exceed meximum word limit of 10";
                    NSLog(@"You exceed meximum word limit of 10");
                    return NO;
                }
            }
        }
        else
        {
            if([array count]>9)
            {
                return NO;
            }
        }
    }
    return YES;
}

//TextFields delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"textField1...%@...text..%@..",textField.text,string);
    
    NSMutableArray *array;
    NSString *textViewStr = textField.text;
    
    if(string.length == 0)
    {
        if ([textViewStr length] > 0) {
            textViewStr = [textViewStr substringToIndex:[textViewStr length] - 1];
            NSLog(@"textField2...%@...text..%@..",textViewStr,string);
        } else {
            //no characters to delete... attempting to do so will result in a crash
        }
    }
    else
    {
        textViewStr = [NSString stringWithFormat:@"%@%@",textViewStr,string];
        NSLog(@"textField3...%@...text..%@..",textViewStr,string);
    }
    
    
    textViewStr = [textViewStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if(textViewStr.length>0){
        array = (NSMutableArray*)[textViewStr componentsSeparatedByString:@" "];
        if([array count]>1)
        [array removeObject:@""];
    }
    
    if ( [string isEqualToString:@""]) {//When detect backspace when have one character.
        if(isRecordingStart){
            return NO;
        }
        else{
            [self resetLUK:[array count]];
            currentLUKIndex = [array count];
        }
    }
    else{
        if([string isEqualToString:@" "])//When user enter one character.
        {
            NSLog(@"textView...%@..",textViewStr);
            if(textViewStr.length>0){
                
                if([array count] > 0 && [array count] < 11){
                    if(currentLUKIndex != [array count]){
                        [self animateView:[array count]];
                        currentLUKIndex = [array count];
                    }
                }
                
                if([array count] > 10)
                {
                    //            message = @"You exceed meximum word limit of 10";
                    NSLog(@"1 You exceed meximum word limit of 10");
                    return NO;
                }
            }
        }
        else
        {
            if([array count] > 10)
            {
                NSLog(@"2 You exceed meximum word limit of 10");
                return NO;
                
            }
        }
    }
    return YES;
}

-(void)resetLUK:(NSInteger)lukCount
{
    lukCount = 10-lukCount;
    
    for(NSInteger i = 9; lukCount>0;lukCount--,i--)
    {
        UIView *view = [viewArr objectAtIndex:i];
        view.hidden = YES;
    }
}


-(void)animateView:(NSInteger)viewIndex
{
    UIView *lukView = [viewArr objectAtIndex:viewIndex-1];
    lukView.hidden = NO;
    lukView.alpha = 0.0f;
    lukView.transform = CGAffineTransformMakeScale(0.3,0.3);
    [UIView beginAnimations:@"fadeInNewView" context:NULL];
    [UIView setAnimationDuration:.5];
    lukView.transform = CGAffineTransformMakeScale(1,1);
    lukView.alpha = 1.0f;
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Top To bottom animation

//    CGRect frame= self.boxView.frame;
//    self.boxView.frame = CGRectMake(0,100, frame.size.width, frame.size.height);
//
//    self.boxView.hidden = NO;
//
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.5];
//
//    CGRect frame1= self.boxView.frame;
//    self.boxView.frame = CGRectMake(0,200, frame1.size.width, frame1.size.height);
//
//    [UIView commitAnimations];

@end
