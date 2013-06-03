//
//  SecureNSUserDefaultsTests.m
//  SecureNSUserDefaultsTests
//
//  Created by Niels Mouthaan on 03-06-13.
//  Copyright (c) 2013 Niels Mouthaan. All rights reserved.
//

#import "SecureNSUserDefaultsTests.h"

#import "NSUserDefaults+SecureAdditions.h"

static NSString * const kKey = @"key";
static NSString * const kGoodSecret = @"UX1qMnfqmPm9GV1Bz6w5h1(41i80|x";
static NSString * const kBadSecret = @"{>8(U4r-1x}#s_R7Tm7c!=})|$.92C";
static NSString * const kString = @"http://www.google.nl";
static NSString * const kAnotherString = @"http://www.facebook.com";
static float const kFloat = 13.37f;
static float const kAnotherFloat = 98.76f;
static float const kInteger = 13;
static float const kAnotherInteger = 99;
static double const kDouble = 13.37;
static double const kAnotherDouble = 98.76;

@implementation SecureNSUserDefaultsTests

- (void)setUp
{
    [super setUp];
    
    // Remove user defaults
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

- (void)testBool
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretBool:YES forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([userDefaults secretBoolForKey:kKey] == YES, @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([userDefaults secretBoolForKey:kKey] == NO, @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([userDefaults secretBoolForKey:kKey] == YES, @"Should be false at this point");
}

- (void)testData
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretObject:[kString dataUsingEncoding:NSUTF8StringEncoding] forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    NSData *value = [userDefaults secretDataForKey:kKey];
    STAssertTrue([value isEqualToData:[kString dataUsingEncoding:NSUTF8StringEncoding]], @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([value isEqualToData:[kAnotherString dataUsingEncoding:NSUTF8StringEncoding]], @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    value = [userDefaults secretDataForKey:kKey];
    STAssertFalse([value isEqualToData:[kAnotherString dataUsingEncoding:NSUTF8StringEncoding]], @"Should be false at this point");
}

- (void)testDictionary
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretObject:[NSDictionary dictionaryWithObject:kString forKey:kKey] forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([[userDefaults secretDictionaryForKey:kKey] isEqualToDictionary:[NSDictionary dictionaryWithObject:kString forKey:kKey]], @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([[userDefaults secretDictionaryForKey:kKey] isEqualToDictionary:[NSDictionary dictionaryWithObject:kAnotherString forKey:kKey]], @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([[userDefaults secretDictionaryForKey:kKey] isEqualToDictionary:[NSDictionary dictionaryWithObject:kString forKey:kKey]], @"Should be false at this point");
}

- (void)testFloat
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretFloat:kFloat forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([userDefaults secretFloatForKey:kKey] == kFloat, @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([userDefaults secretFloatForKey:kKey] == kAnotherFloat, @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([userDefaults secretFloatForKey:kKey] == kFloat, @"Should be false at this point");
}

- (void)testInteger
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretInteger:kInteger forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([userDefaults secretIntegerForKey:kKey] == kInteger, @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([userDefaults secretIntegerForKey:kKey] == kAnotherInteger, @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([userDefaults secretIntegerForKey:kKey] == kInteger, @"Should be false at this point");
}

- (void)testStringArray
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretObject:[NSArray arrayWithObjects:kString, kAnotherString, nil] forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    NSArray *array1 = [userDefaults secretStringArrayForKey:kKey];
    NSArray *array2 = [NSArray arrayWithObjects:kString, kAnotherString, nil];
    STAssertTrue([array1 isEqualToArray:array2], @"Should be true at this point");
    
    // Check value with other value
    NSArray *array3 = [NSArray arrayWithObjects:kString, kString, nil];
    STAssertFalse([array1 isEqualToArray:array3], @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    array1 = [userDefaults secretStringArrayForKey:kKey];
    STAssertFalse([array1 isEqualToArray:array2], @"Should be false at this point");
}

- (void)testString
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretObject:kString forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([[userDefaults secretStringForKey:kKey] isEqualToString:kString], @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([[userDefaults secretStringForKey:kKey] isEqualToString:kAnotherString], @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([[userDefaults secretStringForKey:kKey] isEqualToString:kString], @"Should be false at this point");
    
}

- (void)testDouble
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretDouble:kDouble forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([userDefaults secretDoubleForKey:kKey] == kDouble, @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([userDefaults secretDoubleForKey:kKey] == kAnotherDouble, @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([userDefaults secretDoubleForKey:kKey] == kDouble, @"Should be false at this point");
}

- (void)testURL
{
    // Set value
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecret:kGoodSecret];
    [userDefaults setSecretURL:[NSURL URLWithString:kString] forKey:kKey];
    [userDefaults synchronize];
    
    // Check value with good secret
    STAssertTrue([[[userDefaults secretURLForKey:kKey] absoluteString] isEqualToString:[[NSURL URLWithString:kString] absoluteString]], @"Should be true at this point");
    
    // Check value with other value
    STAssertFalse([[[userDefaults secretURLForKey:kKey] absoluteString] isEqualToString:[[NSURL URLWithString:kAnotherString] absoluteString]], @"Should be false at this point");
    
    // Check value with invalid secret
    [userDefaults setSecret:kBadSecret];
    STAssertFalse([[[userDefaults secretURLForKey:kKey] absoluteString] isEqualToString:[[NSURL URLWithString:kString] absoluteString]], @"Should be false at this point");
}

@end