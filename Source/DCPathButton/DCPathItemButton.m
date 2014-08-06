//
//  DCPathItemButton.m
//  DCPathButton
//
//  Created by tang dixi on 31/7/14.
//  Copyright (c) 2014 Tangdxi. All rights reserved.
//

#import "DCPathItemButton.h"

@interface DCPathItemButton ()

@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation DCPathItemButton

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage backgroundImage:(UIImage *)backgroundImage backgroundHighlightedImage:(UIImage *)backgroundHighlightedImage
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        
        self.image = backgroundImage;
        self.highlightedImage = backgroundHighlightedImage;
        
        self.userInteractionEnabled = YES;
        
        // Configure background
        _backgroundImageView = [[UIImageView alloc]initWithImage:image
                                                            highlightedImage:highlightedImage];
        
        _backgroundImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        //[self insertSubview:_backgroundImageView belowSubview:self];
        [self addSubview:_backgroundImageView];
        
    }
    return self;
}

- (CAAnimationGroup *)expandAnimation
{
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    self.backgroundImageView.highlighted = YES;
    
    if ([_delegate respondsToSelector:@selector(itemButtonTapped)]) {
        [_delegate itemButtonTapped];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint currentLocation = [[touches anyObject]locationInView:self];
    
    if (! CGRectContainsPoint([self scaleRect:self.bounds], currentLocation)) {
        self.highlighted = NO;
        self.backgroundImageView.highlighted = NO;
        return ;
    }
    
    self.highlighted = YES;
    self.backgroundImageView.highlighted = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
    self.backgroundImageView.highlighted = NO;
}

#pragma mark - Scale Item Button

- (CGRect)scaleRect:(CGRect)originRect
{
    return CGRectMake(- originRect.size.width * 2,
                      - originRect.size.height * 2,
                      originRect.size.width * 5,
                      originRect.size.height * 5);
}

@end
