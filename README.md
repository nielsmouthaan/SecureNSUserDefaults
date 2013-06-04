#SecureNSUserDefaults

NSUserDefaults category for iOS and Mac OS X with additional methods to securely save data using strong AES 356-bit encryption.

NSUserDefaults is a great way to store simple data in a persistent way. However, information is stored unencrypted and can easily be read by human beings (e.g. with [iExplorer](http://www.macroplant.com/iexplorer/)). If you want particular information to be stored in a secure way, making it really hard for users to see the actual content, SecureNSUserDefaults might be what you're looking for.

##Installation
I highly recommend you to use CocoaPods for installing this category.

###CocoaPods

```ruby
pod 'SecureNSUserDefaults', '~> 1.0.0'
```

###Manual
1. Copy the files *NSUserDefaults+SecureAdditions.h* and *NSUserDefaults+SecureAdditions.h* into your project;
2. Install [CocoaSecurity](https://github.com/kelp404/CocoaSecurity).

##Usage

###Configure secret
Before SecureNSUserDefaults can be used to get/save encrypted data, make sure to set a **secret** secret:

```objective-c
[[NSUserDefaults standardUserDefaults] setSecret:@"your_secret_goes_here"];
```

Never store the secret somewhere on your file system or in your user preferences but instead put it somewhere static in your code. Preferably use a salt string in combination with something device specific (such as NSUUID's UUIDString method).

###Store information
Storing information is as easy as always. Prefix the normal NSUserDefaults methods with **secret** and your good to go. For example:

```objective-c
[[NSUserDefaults standardUserDefaults] setSecretObject:@"something_only_you_may_know" forKey:@"the_key"];
```

All available methods:
```objective-c
- (void)setSecretBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)setSecretFloat:(float)value forKey:(NSString *)defaultName;
- (void)setSecretInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setSecretDouble:(double)value forKey:(NSString *)defaultName;
- (void)setSecretURL:(NSURL *)url forKey:(NSString *)defaultName;
- (void)setSecretObject:(id)value forKey:(NSString *)defaultName;
```

###Getting information
Getting information works in the say way:

```objective-c
[[NSUserDefaults standardUserDefaults] secretStringForKey:@"the_key"];
```

All available methods:
```objective-c
- (BOOL)secretBoolForKey:(NSString *)defaultName;
- (NSData*)secretDataForKey:(NSString *)defaultName;
- (NSDictionary*)secretDictionaryForKey:(NSString *)defaultName;
- (float)secretFloatForKey:(NSString *)defaultName;
- (NSInteger)secretIntegerForKey:(NSString *)defaultName;
- (NSArray *)secretStringArrayForKey:(NSString *)defaultName;
- (NSString *)secretStringForKey:(NSString *)defaultName;
- (double)secretDoubleForKey:(NSString *)defaultName;
- (NSURL*)secretURLForKey:(NSString *)defaultName;
- (id)secretObjectForKey:(NSString *)defaultName;
```

Note that if the key does not exist or the data could not be decrypted, either *NO*, *0* or *nil* is returned.

##Tests
The class *SecureNSUserDefaultsTests* contains multiple test cases. Clone the entire Xcode project and run the tests to see if everything still works.

## Contact

If you have questions or suggestions, visit [www.nielsmouthaan.nl](http://nielsmouthaan.nl/who-am-i/) and use the contact form to contact me.

## Acknowledgements
* Uses [CocoaSecurity](https://github.com/kelp404/CocoaSecurity) for encrypting/decrypting data.

## License (MIT)
Copyright (c) 2013 Niels Mouthaan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.



