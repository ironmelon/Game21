//
//  IMCardModel.h
//  Game21
//
//  Created by Oleg Dynnikov on 6/5/15.
//  Copyright (c) 2015 Oleg Dynnikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMCardModel : NSObject

@property (assign, nonatomic) NSInteger valueCard;
@property (strong, nonatomic) NSString *nameCard;

- (instancetype)initWithName:(NSString*)name andValue:(NSInteger)value;

@end
