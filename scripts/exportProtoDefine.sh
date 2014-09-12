#!/bin/sh

#  exportProtoDefine.sh
#  IMiPhone
#
#  Created by 尹晓君 on 14-9-11.
#  Copyright (c) 2014年 尹晓君. All rights reserved.
cd $( dirname ${0} )
java -jar ../tools/com.jascava.tools_v1.2.0.v20140911.jar ExportProtoDefine -h ./MessageDefine.pch -url "http://local.admin.taiqiu.com:7070/tool/proto.php?action=get&prid=1&kind=3&verify=fef5f949928796a4bf733e494c5008dc"
cp ./MessageDefine.pch ../IMiPhone/