#!/bin/bash

bot_process_targets=("python3 dictbot/main.py" "python3 translate-bot/translate-main.py")
initiated_by=$(whoami)

echo "Starting bots as $initiated_by ...."
sleep 1

for bot in "${bot_process_targets[@]}"; do
        echo " "
        echo "......................................................................................."
        #create file path at which python will call the scripts
        IFS=" " read -a python_call_attrs <<< "$bot"
        echo "Starting: ${python_call_attrs[0]} ~/local_scripts/${python_call_attrs[1]}"

        #run the scripts to start the bot
        nohup python3 "local_scripts/${python_call_attrs[1]}" > /dev/null 2>&1 &

        #get process information
        process=$(ps -ef | grep "$bot" | grep "$initiated_by")
        echo "Process Found."
        echo "Details: $process"
        IFS=' ' read -a process_attrs <<< "$process"
        PID="${process_attrs[1]}"
        echo "Process ID: $PID"
        echo "......................................................................................."
        sleep .5
done
