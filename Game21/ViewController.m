//
//  ViewController.m
//  Game21
//
//  Created by Oleg Dynnikov on 3/16/15.
//  Copyright (c) 2015 Oleg Dynnikov. All rights reserved.
//

#import "ViewController.h"
#import "IMCardModel.h"

@interface ViewController ()
{
    NSInteger userCardNextStep;
    NSInteger compCardNextStep;
    NSInteger userCurrentPoints;
    NSInteger compCurrentPoints;
    NSInteger compWinCount;
    NSInteger userWinCount;
    NSInteger userSubviewCardCount;
    NSInteger compSubviewCardCount;
    NSMutableArray *cards;
    BOOL gameIsStop;
    BOOL buttonStop;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    userCurrentPoints = 0;
    compCurrentPoints = 0;
    gameIsStop = NO;
    buttonStop = NO;
    compWinCount = 0;
    userWinCount = 0;
    userCardNextStep = 0;
    compCardNextStep = 0;
    userSubviewCardCount = 0;
    compSubviewCardCount = 100;
    
    self.generalLabel.text = @"Hello!!! This is 21.";
    
    [self printUserTotalWin];
    [self printCompTotalWin];
    [self printUserPoints];
    [self printCompPoints];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenBackground.png"]];
    
    cards = [[NSMutableArray alloc] init];
    NSArray *cardsValue = @[@6, @7, @8, @9, @10, @2, @3, @4, @11];
    NSArray *cardsName = [NSArray arrayWithObjects: @"6.png", @"7.png", @"8.png", @"9.png", @"10.png", @"jack.png", @"queen.png", @"king.png", @"ace.png", nil];
    
    for (int i = 0; i < 9; i++) {
        IMCardModel *c = [[IMCardModel alloc] initWithName:[cardsName objectAtIndex:i] andValue:[[cardsValue objectAtIndex:i] integerValue]];
        [cards addObject:c];
    }
    
    UIImageView *cardShirt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shirt.png"]];
    [self.view addSubview:cardShirt];
    [cardShirt setFrame:CGRectMake(230, 400, cardShirt.frame.size.width, cardShirt.frame.size.height)];
    
    self.generalLabel.backgroundColor = [UIColor clearColor];
    self.generalLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.generalLabel.layer.borderWidth = 1.5;
    self.generalLabel.textColor = [UIColor yellowColor];
    
    self.userPointsLabel.backgroundColor = [UIColor clearColor];
    self.userPointsLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.userPointsLabel.textColor = [UIColor yellowColor];
    self.userPointsLabel.layer.borderWidth = 2.0;
    
    self.compPointsLabel.backgroundColor = [UIColor clearColor];
    self.compPointsLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.compPointsLabel.textColor = [UIColor yellowColor];
    self.compPointsLabel.layer.borderWidth = 2.0;
    
    self.userTotalWinLabel.textColor = [UIColor redColor];
    self.compTotalwinLabel.textColor = [UIColor redColor];
    
    UIImage* user = [UIImage imageNamed:@"userImage.png"];
    UIImageView *userPicture = [[UIImageView alloc] initWithImage:user];
    [self.view addSubview:userPicture];
    [userPicture setFrame:CGRectMake(0, 67, 100, 100)];
    
    UIImage* comp = [UIImage imageNamed:@"computerImage.png"];
    UIImageView *compPicture = [[UIImageView alloc] initWithImage:comp];
    [self.view addSubview:compPicture];
    [compPicture setFrame:CGRectMake(240, 67, 75, 100)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startButton:(id)sender {
    
    for (int i = 1; i <= userSubviewCardCount; i++){
        UIView *viewToRemove = [self.view viewWithTag:i];
        [viewToRemove removeFromSuperview];
    }
    
    for (int i = 100; i <= compSubviewCardCount; i++){
        UIView *viewToRemove = [self.view viewWithTag:i];
        [viewToRemove removeFromSuperview];
    }
    
    userSubviewCardCount++;
    userCardNextStep = 0;
    compCardNextStep = 0;
    buttonStop = NO;
    
    NSInteger randCard = [self getRandomCard];
    IMCardModel* card = [cards objectAtIndex:randCard];
    userCurrentPoints = card.valueCard;
    self.generalLabel.text = @"You start game and got your first card!!!";
    [self printUserPoints];
    [self printCompPoints];
    [self printUserTotalWin];
    [self printCompTotalWin];
    [self cardMoveToUser:randCard];
    
}

- (IBAction) getCardButton:(id)sender {
    
    if (!buttonStop) {
        
        userCardNextStep += 15;
        userSubviewCardCount++;
        
        NSInteger randCard = [self getRandomCard];
        IMCardModel* card = [cards objectAtIndex:randCard];
        userCurrentPoints = userCurrentPoints + card.valueCard;
        self.generalLabel.text = @"Press get or enough!";
        [self printUserPoints];
        [self cardMoveToUser:randCard];
        
        
        if (userCurrentPoints > 21) {
            [self printCompWinToGeneralLabel];
            [self compTotalWinCount];
            gameIsStop = YES;
            
        } else if (userCurrentPoints == 21) {
            [self printUserWinToGeneralLabel];
            [self userTotalWinCount];
            gameIsStop = YES;
        }
        
        if (gameIsStop == YES) {
            
            userCurrentPoints = 0;
            userCardNextStep = 0;
            gameIsStop = NO;
            buttonStop = YES;
        }
    }
    
    
}

- (IBAction) enoughCardButton:(id)sender {
    
    if (!buttonStop) {
        
        BOOL compPlay = YES;
        
        while (compPlay == YES) {
            
            NSInteger randCard = [self getRandomCard];
            IMCardModel *card = [cards objectAtIndex:randCard];
            
            compCurrentPoints = compCurrentPoints + card.valueCard;
            
            if (compCurrentPoints == 17) {
                compPlay = NO;
            } else if (compCurrentPoints == 21) {
                compPlay = NO;
            } else if (compCurrentPoints > 21) {
                compPlay = NO;
            } else if (compCurrentPoints == 20) {
                compPlay = NO;
            }
            
            [self cardMoveToComp:randCard];
            compSubviewCardCount++;
            compCardNextStep += 15;
        }
        
        [self printCompPoints];
        
        if (compCurrentPoints > 21) {
            [self printUserWinToGeneralLabel];
            [self userTotalWinCount];
            
        } else if (compCurrentPoints >= userCurrentPoints) {
            [self printCompWinToGeneralLabel];
            [self compTotalWinCount];
            
        } else if (compCurrentPoints < userCurrentPoints) {
            [self printUserWinToGeneralLabel];
            [self userTotalWinCount];
        }
        
        
        if (compPlay == NO){
            buttonStop = YES;
            compCurrentPoints = 0;
            compCardNextStep = 0;
        }
        
    }
    
}

- (IBAction) backButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) printUserPoints {
    NSString* str = [NSString stringWithFormat:@"%li",userCurrentPoints];
    self.userPointsLabel.text = str;
}

- (void) printCompPoints {
    NSString *str = [NSString stringWithFormat:@"%li",compCurrentPoints];
    self.compPointsLabel.text = str;
}

- (void) printUserTotalWin {
    NSString *userWin = [NSString stringWithFormat:@"%li",userWinCount];
    self.userTotalWinLabel.text = userWin;
}

- (void) printCompTotalWin {
    NSString *compWin = [NSString stringWithFormat:@"%li",compWinCount];
    self.compTotalwinLabel.text = compWin;
}

- (void) userTotalWinCount {
    userWinCount++;
}

- (void) compTotalWinCount {
    compWinCount++;
}

- (void) printUserWinToGeneralLabel {
    self.generalLabel.text = @"You WIN!!! =) Computer LOSE!!!";
}

- (void) printCompWinToGeneralLabel {
    self.generalLabel.text = @"Computer WIN!!! You LOSE =(";
}

- (void) cardMoveToUser:(NSInteger)index {
    IMCardModel *card = cards[index];
    UIImageView *cardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:card.nameCard]];
    cardView.tag = userSubviewCardCount;
    [self.view addSubview:cardView];
    [cardView setFrame:CGRectMake(230, 400, cardView.frame.size.width, cardView.frame.size.height)];
    
    [UIView animateWithDuration:0.5 animations:^{cardView.frame = CGRectMake(5 + userCardNextStep, 210, cardView.frame.size.width, cardView.frame.size.height);} completion:^(BOOL finished){
    }];
}

- (void) cardMoveToComp:(NSInteger)index {
    IMCardModel *card = cards[index];
    UIImageView *cardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:card.nameCard]];
    cardView.tag = compSubviewCardCount;
    [self.view addSubview:cardView];
    [cardView setFrame:CGRectMake(230, 400, cardView.frame.size.width, cardView.frame.size.height)];
    
    [UIView animateWithDuration:0.5 animations:^{cardView.frame = CGRectMake(170 + compCardNextStep, 210, cardView.frame.size.width, cardView.frame.size.height);} completion:^(BOOL finished){
    }];
}

- (NSInteger) getRandomCard {
    NSInteger randCard = arc4random() % 9;
    return randCard;
}

@end






