//
//  ViewController.m
//  Tippy
//
//  Created by britneyting on 6/25/19.
//  Copyright © 2019 britneyting. All rights reserved.
//

#import "ViewController.h"

// classes in C are split into two things: definition and implementation

@interface ViewController () //definition of class
@property (weak, nonatomic) IBOutlet UITextField *billField; //crtl drag txt field here to create property
@property (weak, nonatomic) IBOutlet UILabel *tipLabel; // variables: name of variable followed by clue on what type it is
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
// after setting these properties, we'll have created objects e.g self.tipLabel
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *billText;
@property (weak, nonatomic) IBOutlet UILabel *tipText;
@property (weak, nonatomic) IBOutlet UILabel *totalText;
@property (weak, nonatomic) IBOutlet UIView *grayBox;

@end

@implementation ViewController //implementation of class

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onTap:(id)sender { //app performs an action when you tap on the screen, prints out hello
    NSLog(@"Hello"); //print function, make sure to put @
    [self.view endEditing:YES]; //self.view is an object/property, endEditing is the method name, YES is the parameter, equiv to self.view.endEditing(YES) -- this function closes the keyboard when you tap outside
}
// need to ensure that phone registers changes in text field and that tip and total dynamically change
// right click the text field and then crtl drag 'Editing Changes' to down below. This allows you to edit and dynamically change the bill input
- (IBAction)onEdit:(id)sender {
    double bill = [self.billField.text doubleValue]; /* sets the variable 'bill' to the user input of billField (property as assigned above). However, self.billField.text returns an NSString, so we need to call the method doubleValue on it to convert it to a double */
    
    // create an array to store the default tip %s so you can tap on each one and change dynamically
    // @(number) creates an NSNumber, need to use this in the array declaration below to store #s in the list bc objC doesn't process primitive types
    NSArray *percentages = @[@(0.15), @(0.18), @(0.2)]; // NSArray of NSNumbers wrapping a double
    
    // taking the selected % and then making changing it from an NSNumber to a double (since we had an NSArray of NSNumbers
    // calling a function of a function in Python using multiple dots is equivalent to using nested brackets in objC
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    // %f means inserting a decimal number. % is a placeholder. For every %, need a comma list
    // all about creating an NSString based on this format
    // .2 means truncating at 2 decimal places
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip]; // calling method on String, insert the decimal # tip as a str
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
    // need to right click the Segemented Control and then crtl drag Value Change to this IBAction
}
// want to animate the bill text field so that when you tap it, it moves down

// in the beginning, when you tap it, the text field moves down (+30)
- (IBAction)onEditingBegin:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{ //anything inside this block of code gets animated (the caret)
        self.billField.frame = CGRectMake(self.billField.frame.origin.x,
                                          self.billField.frame.origin.y + 100,
                                          self.billField.frame.size.width,
                                          self.billField.frame.size.height);
        self.tipLabel.alpha = 0; // makes the tip label invisble
        self.totalLabel.alpha = 0;
        self.tipControl.alpha = 0;
        self.tipText.alpha = 0;
        self.totalText.alpha = 0;
        self.grayBox.alpha = 0;

    }];
}
// in the end, after you tap outside the text field, the text field moves back up (-30)
- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y -= 100;
    
    [UIView animateWithDuration:0.2 animations:^{ //anything inside this block of code gets animated (the caret). Makes the moving smoother cuz it takes 0.2 s
        self.billField.frame = newFrame;
        
        self.tipLabel.alpha = 1; // Make the tip label fully visible again. If you want everything to fade away as you press on the text field, just set alpha of everything else to 0
        self.totalLabel.alpha = 1;
        self.tipControl.alpha = 1;
        self.tipText.alpha = 1;
        self.totalText.alpha = 1;
        self.grayBox.alpha = 1;
        
    }];
}


@end
