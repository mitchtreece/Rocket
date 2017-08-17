//
//  Rocket.h
//  Rocket
//
//  Created by Mitch Treece on 8/7/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

#define RKTInfo(message) [Rocket log:message \
                              prefix:nil \
                               level:1 \
                                file:[NSString stringWithFormat:@"%s", __FILE__] \
                            function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] \
                                line:__LINE__]

#define RKTWarn(message) [Rocket log:message \
                              prefix:nil \
                               level:2 \
                                file:[NSString stringWithFormat:@"%s", __FILE__] \
                            function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] \
                                line:__LINE__]

#define RKTError(message) [Rocket log:message \
                               prefix:nil \
                                level:3 \
                                 file:[NSString stringWithFormat:@"%s", __FILE__] \
                             function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] \
                                 line:__LINE__]

#define RKTDebug(message) [Rocket log:message \
                               prefix:nil \
                                level:4 \
                                 file:[NSString stringWithFormat:@"%s", __FILE__] \
                             function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] \
                                 line:__LINE__]

#define RKTVerbose(message) [Rocket log:message \
                                 prefix:nil \
                                  level:5 \
                                   file:[NSString stringWithFormat:@"%s", __FILE__] \
                               function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] \
                                   line:__LINE__]

#define RKTLog(message) RKTDebug(message)

#define RKTCustomLog(prefix, message, level) [Rocket log:message \
                                                  prefix:prefix \
                                                   level:level \
                                                    file:[NSString stringWithFormat:@"%s", __FILE__] \
                                                function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] \
                                                    line:__LINE__]
