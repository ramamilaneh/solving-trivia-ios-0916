//  FISAppDelegate.h

@interface FISAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSString *)solveTrivia;
-(NSString *)encodeWithMessage:(NSString *)message andOffset:(NSInteger)key;
-(NSString *)ddecodeWithMessage:(NSString *)message andOffset:(NSInteger)key;


@end
