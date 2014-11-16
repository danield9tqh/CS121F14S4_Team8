//
//  ExplosionScene.m
//  PowerUP
//
//  Created by Cyrus Huang on 11/13/14.
//  Copyright (c) 2014 CS121F14S4_Team8. All rights reserved.
//

#import "ExplosionScene.h"
#import <SpriteKit/SpriteKit.h>

@implementation ExplosionScene

- (void)didMoveToView: (SKView *) view
{
    [self setBackgroundColor:[UIColor blackColor]];
}

-(void)dealloc {
    NSLog(@"Dealloc <scene name>");
}

- (void)createExplosionAtX:(int) x AndY: (int) y
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    NSString* explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
    
    SKEmitterNode* explosionNode = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    [explosionNode setNumParticlesToEmit:1000];
    [explosionNode setParticleBirthRate:450];
    [explosionNode setParticleLifetime:2];
    [explosionNode setXScale:1];
    [explosionNode setYScale:1];
    
    explosionNode.position = CGPointMake(x,y);
    
    [self addChild:explosionNode];
}

@end