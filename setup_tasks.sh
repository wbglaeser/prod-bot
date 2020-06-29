#!/bin/sh

########
# Auxialliary function
########
welcome () {
    # clear screem
    echo '\x1B[2J\x1B[1;1H'

    # welcome message
    echo "Good Morning friend!"

    # check if help is needed
    echo "You have lots to do today?"
    read -sp "[yes/no]: " answer1

    if [ "$answer1" != "yes" ]; then
        echo "\nWell, good for you! Have a wonderful day."
        exit 0
    else
        echo "\nOk, lets get some structure in your workday."
    fi
}

add_work () {
    echo "\nWhat to do you need to do then?"
    read -sp "[Work/Project]: " answer_work

    check_answer $answer_work add_work

    type[$idx]=$answer_work
}

add_description () {
    echo "\nWant to give more details?"
    read -sp "[Ticket x/Ticket y]" answer_ticket

    check_answer $answer_ticket add_description

    description[$idx]=$answer_ticket
}

add_start_time () {
    echo "\nWhat do time do you need to start with this?"
    read -sp "[HH:MM]: " start_time

    check_answer $start_time add_start_time

    start_time[$idx]=$start_time
}

add_end_time () {
    echo "\nWhat do time do you need to finish with this?"
    read -sp "[HH:MM]: " end_time

    check_answer $end_time add_end_time

    end_time[$idx]=$end_time
}

check_answer () {
    echo "\nYour answer: $1"
    read -sp "[y/n]: " check

    if [ "$check" != "y" ]; then
        $2
    fi
}

next_task () {
    echo "\nDo you want to add another task?"
    read -sp "[y/n]" next_task

    if [ "$next_task" != "y" ]; then
        echo "\nAlright then, I look forward to keeping you on track :/\n"
        break
    fi
}

# arrays setup
declare -a type
declare -a description
declare -a start_time
declare -a end_time

########
# Usage flow
########

welcome

# ask for tasks and time slots
idx=0
while True
do
    add_work
    add_description
    add_start_time
    add_end_time
    echo "\nAdding new task ..."
    next_task

    # increase loop
    idx=`expr $idx + 1`
done

########
# start notifier script
########
/bin/sh ./notifier.sh "${type[@]}" "-" "${description[@]}" "-" "${start_time[@]}" "-" "${end_time[@]}" &
