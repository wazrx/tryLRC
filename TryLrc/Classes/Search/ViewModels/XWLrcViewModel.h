//
//  XWLrcViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTableViewModel.h"

@interface XWLrcViewModel : XWTableViewModel


- (void)xw_setLrcLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;

- (void)xw_getLrcDataWithSongID:(NSString *)songID;

@end
