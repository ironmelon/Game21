//
//  IMCardModel.m
//  Game21
//
//  Created by Oleg Dynnikov on 6/5/15.
//  Copyright (c) 2015 Oleg Dynnikov. All rights reserved.
//

#import "IMCardModel.h"

@implementation IMCardModel

- (instancetype)initWithName:(NSString*)name andValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _nameCard = name;
        _valueCard = value;
    }
    return self;
}





@end
