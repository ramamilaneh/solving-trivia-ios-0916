//  FISAppDelegate.m

#import "FISAppDelegate.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *result = [self solveTrivia];
    NSLog(@"%@",result);
    NSString *encoded = [self encodeWithMessage:@"I'm a tiger" andOffset:5];
    NSLog(@"%@&&&&&&&&&&&&&&",encoded);
    return YES;
}

-(NSString *)solveTrivia {
    NSDictionary *stateCapitals= @{@"Alabama":@"Montgomery",
                                   @"Alaska":@"Juneau",
                                   @"Arizona":@"Phoenix",
                                   @"Arkansas":@"Little Rock",
                                   @"California":@"Sacramento",
                                   @"Colorado":@"Denver",
                                   @"Connecticut":@"Hartford",
                                   @"Delaware":@"Dover",
                                   @"Florida":@"Tallahassee",
                                   @"Georgia":@"Atlanta",
                                   @"Hawaii":@"Honolulu",
                                   @"Idaho":@"Boise",
                                   @"Illinois":@"Springfield",
                                   @"Indiana":@"Indianapolis",
                                   @"Iowa":@"Des Moines",
                                   @"Kansas":@"Topeka",
                                   @"Kentucky":@"Frankfort",
                                   @"Lousiana":@"Baton Rouge",
                                   @"Maine":@"Augusta",
                                   @"Maryland":@"Annapolis",
                                   @"Massassachusetts":@"Boston",
                                   @"Michigan":@"Lansing",
                                   @"Minnesota":@"Saint Paul",
                                   @"Mississippi":@"Jackson",
                                   @"Missouri":@"Jefferson City",
                                   @"Montana":@"Helena",
                                   @"Nebraska":@"Lincoln",
                                   @"Nevada":@"Carson City",
                                   @"New Hampshire":@"Concord",
                                   @"New Jersey":@"Trenton",
                                   @"New Mexico":@"Santa Fe",
                                   @"New York":@"Albany",
                                   @"North Carolina":@"Raleigh",
                                   @"North Dakota":@"Bismarck",
                                   @"Ohio":@"Columbus",
                                   @"Oklahoma":@"Oklahoma City",
                                   @"Oregon":@"Salem",
                                   @"Pennsylvania":@"Harrisburg",
                                   @"Rhode Island":@"Providence",
                                   @"South Carolina":@"Columbia",
                                   @"South Dakota":@"Pierre",
                                   @"Tennessee":@"Nashville",
                                   @"Texas":@"Austin",
                                   @"Utah":@"Salt Lake City",
                                   @"Vermont":@"Montpelier",
                                   @"Virgina":@"Richmond",
                                   @"Washington":@"Olympia",
                                   @"West Virginia":@"Charleston",
                                   @"Wisconsin":@"Madison",
                                   @"Wyoming":@"Cheyenne"};
    BOOL isTrivia = NO;
    
    for(NSString *key in stateCapitals) {
        
        NSString *newKey = [NSString stringWithString:key];
        NSString *newvalue = [NSString stringWithString:stateCapitals[key]];
        newKey = [[key stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
        newvalue = [[stateCapitals[key] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
        NSMutableSet *keyCharacters = [NSMutableSet set];
        NSMutableSet *valueCharacters = [NSMutableSet set];

        for(NSUInteger i = 0; i<[newKey length]; i ++){
            [keyCharacters addObject:[newKey substringWithRange:NSMakeRange(i, 1)]];
        }
        for(NSUInteger i = 0; i<[newvalue length]; i ++){
            [valueCharacters addObject:[newvalue substringWithRange:NSMakeRange(i, 1)]];
        }
       
        if ([keyCharacters intersectsSet:valueCharacters] == NO) {
            isTrivia = YES;
            return [NSString stringWithString:key];
        }
        
    }
    return nil;
    }

static NSString * const alphabet = @"abcdefghijklmnopqrstuvwxyz";
static NSString * const ALPHABET = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";

-(NSString *)encodeWithMessage:(NSString *)message andOffset:(NSInteger)key
{
    if (key%26 == 0) return message;
    
    NSCharacterSet *lowercaseAlphabet = [NSCharacterSet characterSetWithCharactersInString:alphabet];
    NSCharacterSet *uppercaseAlphabet = [NSCharacterSet characterSetWithCharactersInString:ALPHABET];
    
    NSMutableString *encodedMessage = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < message.length; i++) {
        unichar character = [message characterAtIndex:i];
        if ([lowercaseAlphabet characterIsMember:character]) {
            character = [self encodeCharacterWithAlphabetString:alphabet andCharacter:character andKey:key];
        } else if ([uppercaseAlphabet characterIsMember:character]) {
            character = [self encodeCharacterWithAlphabetString:ALPHABET andCharacter:character andKey:key];
        }
        [encodedMessage appendFormat:@"%c", character];
    }
    return encodedMessage;
}

-(NSString *)decodeWithMessage:(NSString *)encodedMessage andOffset:(NSInteger)key
{
    if (key%26 == 0) return encodedMessage;
    
    NSCharacterSet *lowercaseAlphabet = [NSCharacterSet characterSetWithCharactersInString:alphabet];
    NSCharacterSet *uppercaseAlphabet = [NSCharacterSet characterSetWithCharactersInString:ALPHABET];
    
    NSMutableString *decodedMessage = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < encodedMessage.length; i++) {
        char character = [encodedMessage characterAtIndex:i];
        if ([lowercaseAlphabet characterIsMember:character]) {
            character = [self decodeCharacterWithAlphabetString:alphabet andCharacter:character andKey:key];
        } else if ([uppercaseAlphabet characterIsMember:character]) {
            character = [self decodeCharacterWithAlphabetString:ALPHABET andCharacter:character andKey:key];
        }
        NSLog(@"append %c to decode", character);
        [decodedMessage appendFormat:@"%c", character];
    }
    return decodedMessage;
}


-(char)encodeCharacterWithAlphabetString:(NSString *)alphabetString andCharacter:(char)character andKey:(NSInteger)keyInt
{
    NSRange rangeOfCharacterInAlphabet = [alphabetString rangeOfString:[NSString stringWithFormat:@"%c", character]];
    NSInteger translatedKey = rangeOfCharacterInAlphabet.location + (keyInt%26);
    if (translatedKey > 26) {
        translatedKey = translatedKey - 26;
    }
    return [alphabetString characterAtIndex:translatedKey];
}

-(char)decodeCharacterWithAlphabetString:(NSString *)alphabetString andCharacter:(char)character andKey:(NSInteger)keyInt
{
    NSRange rangeOfCharacterInAlphabet = [alphabetString rangeOfString:[NSString stringWithFormat:@"%c", character]];
    NSInteger translatedKey = rangeOfCharacterInAlphabet.location - (keyInt%26);
    if (translatedKey < 0) {
        translatedKey = translatedKey + 26;
    }
    return [alphabetString characterAtIndex:translatedKey];
}
@end
