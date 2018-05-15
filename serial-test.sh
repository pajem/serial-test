#!/bin/bash

# parse arguments
if [ $# -ne 3 ]
  then
    echo "serial-test.sh [tx_dev] [rx_dev] [baud_rate]"
    exit
fi
tx_dev=$1
rx_dev=$2
baud_rate=$3

# configure serial devices
stty -F $tx_dev raw ispeed $baud_rate ospeed $baud_rate -echo
stty -F $rx_dev raw ispeed $baud_rate ospeed $baud_rate -echo

# set duration
duration_msec=1000

# set period
period_msec=100
period_sec=$(echo $period_msec/1000 | bc -l)

# clean-up
rm -f tx.log
rm -f rx.log

# receive data and write to file
cat $rx_dev >> rx.log &
cat_pid=$!
sleep 0.1

msec=0
while [ $msec -lt $duration_msec ]
do
  # transmit data and write to file
  echo -ne "test" | tee -a $tx_dev >> tx.log

  # wait
  sleep $period_sec
  let msec=msec+$period_msec
done

# terminate receive
kill $cat_pid

# compare tx and rx data
diff -sq tx.log rx.log
