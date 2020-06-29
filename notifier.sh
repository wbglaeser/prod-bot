#!/bin/sh

IFS='-' read -ra conc_array <<< "$@"
IFS=' ' read -ra type <<< "${conc_array[0]}"
IFS=' ' read -ra details <<< "${conc_array[1]}"
IFS=' ' read -ra start_time <<< "${conc_array[2]}"
IFS=' ' read -ra end_time <<< "${conc_array[3]}"

while True
do
    current_time="`date +"%H:%M"`"
    for i in $(seq 0 ${#start_time[@]})
    do
        stime=${start_time[${i}]}
        if [ "$stime" == $current_time ]; then
            type_of_work=${type[i]}
            echo "${type[i]} | URGENT\nInfo: ${description[i]} | Time: ${start_time[i]} to ${end_time[i]}" | terminal-notifier -sound default
        fi
    done
    sleep 60
done
