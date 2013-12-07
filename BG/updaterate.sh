#!/bin/bash
UPDATERATE=0.0 
UPDATEINT=0
while [ $UPDATEINT -lt 55 ]; do
	READRATE=$(echo "1-2*$UPDATERATE" | bc);
	echo "Update rate: $UPDATERATE, Read rate: $READRATE"
	java -cp build/classes:lib/mysql-connector-java-5.1.18-bin.jar:lib/log4j-1.2.8.jar edu.usc.bg.base.Client -schema -db memcached.WhalinMemcachedBGClient
	java -cp build/classes:lib/mysql-connector-java-5.1.18-bin.jar:lib/log4j-1.2.8.jar edu.usc.bg.base.Client -loadindex -db memcached.WhalinMemcachedBGClient -P /Users/dliu/584Project/BG/workloads/populateDB -p threadcount=10
	java -cp build/classes:lib/mysql-connector-java-5.1.18-bin.jar:lib/log4j-1.2.8.jar edu.usc.bg.base.Client -t -db memcached.WhalinMemcachedBGClient -P workloads/MixOfAction -p DeleteCommentOnResourceAction=$UPDATERATE -p PostCommentOnResourceAction=$UPDATERATE -p ViewCommentsOnResourceAction=$READRATE -p maxexecutiontime=600 -p usercount=10000 -p initapproach=deterministic -p resourcecountperuser=10 -p friendcountperuser=10 -p confperc=1 -p numloadthreads=10 -p useroffset=0 -p zipfianmean=0.27 -p requestdistribution=dzipfian -p enablelogging=true -p validationapproach=interval
	UPDATERATE=$(echo "$UPDATERATE+0.05" | bc)
	let UPDATEINT=UPDATEINT+5
	echo "Sleep for 15s"
	sleep 15
done
	

