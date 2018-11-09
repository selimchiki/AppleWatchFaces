#import "KKInterfaceController.h"

@import ObjectiveC.runtime;

@interface NSObject (fs_override)
+(id)sharedApplication;
-(id)keyWindow;
-(id)rootViewController;
-(NSArray *)viewControllers;
-(id)view;
-(NSArray *)subviews;
-(id)timeLabel;
-(id)layer;
@end

@implementation KKInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)didAppear
{
	/* Nasty Hack to make the digital time overlay disappear */
	NSArray *views = [[[[[[[NSClassFromString(@"UIApplication") sharedApplication] keyWindow] rootViewController] viewControllers] firstObject] view] subviews];
	
	for (NSObject *view in views)
	{
		if ([view isKindOfClass:NSClassFromString(@"SPFullScreenView")])
			[[[view timeLabel] layer] setOpacity:0];
	}
}


@end
