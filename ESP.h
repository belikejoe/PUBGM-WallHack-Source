//1

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Lvliangliangwudifangfeng)(NSArray *data, NSArray *hpData, NSArray *disData,NSArray *nameData,NSArray *aiData,NSArray *data1,NSArray *data2,NSArray *data3,NSArray *data4,NSArray *data5,NSArray *data6,NSArray *data7,NSArray *data8);
@interface lvllzuobiao : NSObject

+ (instancetype)data;

- (void)fetchData:(Lvliangliangwudifangfeng)block;

@end

NS_ASSUME_NONNULL_END

