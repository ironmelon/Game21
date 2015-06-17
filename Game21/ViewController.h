//
//  ViewController.h
//  Game21
//
//  Created by Oleg Dynnikov on 3/16/15.
//  Copyright (c) 2015 Oleg Dynnikov. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *generalLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *compPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTotalWinLabel;
@property (weak, nonatomic) IBOutlet UILabel *compTotalwinLabel;

- (IBAction)startButton:(id)sender;
- (IBAction)getCardButton:(id)sender;
- (IBAction)enoughCardButton:(id)sender;
- (IBAction)backButton:(id)sender;



@end

