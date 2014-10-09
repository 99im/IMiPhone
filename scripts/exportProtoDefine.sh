#!/bin/sh

#  exportProtoDefine.sh
#  IMiPhone
#
#  Created by 尹晓君 on 14-9-11.
#  Copyright (c) 2014年 尹晓君. All rights reserved.
cd $( dirname ${0} )
java -jar ../tools/com.jascava.tools.jar ExportProtoDefine -h ./MessageHttpDefine.pch -url "http://local.admin.taiqiu.com:7070/tool/proto.php?action=get&prid=1&kind=3&verify=fef5f949928796a4bf733e494c5008dc"
cp ./MessageHttpDefine.pch ../IMiPhone/

java -jar ../tools/com.jascava.tools.jar ExportProtoDefine -h ./MessageSocketDefine.pch -url "http://local.admin.taiqiu.com:7070/tool/proto.php?action=get&prid=1&kind=1&verify=fef5f949928796a4bf733e494c5008dc"
cp ./MessageSocketDefine.pch ../IMiPhone/

java -jar ../tools/com.jascava.tools.jar ExportProtoDefine -h ./NSNumber+IMNWError.m -url "http://local.admin.taiqiu.com:7070/tool/error.php?action=get&prid=1&verify=fef5f949928796a4bf733e494c5008dc" -t error
cp ./NSNumber+IMNWError.m ../IMiPhone/