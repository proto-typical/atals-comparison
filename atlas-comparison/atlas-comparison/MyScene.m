//
//  MyScene.m
//  atlas-comparison
//
//  Created by Prototypical on 8/11/14.
//  Copyright (c) 2014 Prototypical. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        isAtlas = NO;
        [self runTest];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    // rerun test with other mode
    isAtlas = !isAtlas;
    [self removeAllChildren];
    [self runTest];
    
}


- (void)runTest
{
    
    SKTextureAtlas *atlas = [SKTextureAtlas  atlasNamed:@"ring"];
    NSMutableArray *anim = [NSMutableArray array];
    
    for (int index = 0; index < 60; index++)
    {
        NSString *textureName = [NSString stringWithFormat:@"coin-spin-%i", index];
        SKTexture *texture;
        if (isAtlas)
        {
            texture = [atlas textureNamed:textureName];
            
        }
            else
            {
                texture = [SKTexture textureWithImageNamed:textureName];
            }
        [anim addObject:texture];
    }
        
    for (int i=0; i < 1600; i++) {
        
        
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:anim[0]];
        [self addChild:sprite];
        
        sprite.xScale = 0.35;
        sprite.yScale = 0.35;
        
        int col = i % 70;
        int row = i / 70;
        
        float spawnX = col * 10 + 50;
        float spawnY = row * 40 + 50;
        
        
        sprite.position = CGPointMake(spawnX,spawnY);
        
        SKAction *waitToAnimate = [SKAction waitForDuration:i * .002];
        SKAction *actionBlock = [SKAction runBlock:^(void)
                                 {
                                     SKAction *animate = [SKAction animateWithTextures:anim timePerFrame:.03];
                                     SKAction *loop = [SKAction repeatActionForever:animate];
                                     [sprite runAction:loop];
                                     
                                     
                                 }];
        SKAction *startSequence = [SKAction sequence:@[waitToAnimate, actionBlock]];
        [sprite runAction:startSequence];
        
    }
    
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
