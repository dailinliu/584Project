#!/bin/bash
RUNTIME=10
while [ $RUNTIME -lt 600 ]; do
	java -cp build/classes:lib/mysql-connector-java-5.1.18-bin.jar:lib/log4j-1.2.8.jar edu.usc.bg.base.Client -schema -db memcached.WhalinMemcachedBGClient
	java -cp build/classes:lib/mysql-connector-java-5.1.18-bin.jar:lib/log4j-1.2.8.jar edu.usc.bg.base.Client -loadindex -db memcached.WhalinMemcachedBGClient -P /Users/dliu/584Project/BG/workloads/populateDB -p threadcount=10
	java -cp build/classes:lib/mysql-connector-java-5.1.18-bin.jar:lib/log4j-1.2.8.jar edu.usc.bg.base.Client -t -db memcached.WhalinMemcachedBGClient -P workloads/MixOfAction -p maxexecutiontime=$RUNTIME -p usercount=10000 -p initapproach=deterministic -p resourcecountperuser=10 -p friendcountperuser=10 -p confperc=1 -p numloadthreads=10 -p useroffset=0 -p zipfianmean=0.27 -p requestdistribution=dzipfian -p enablelogging=true -p validationapproach=interval
	let RUNTIME=RUNTIME+60
	echo "Sleep for 15s"
	sleep 15
done
	

