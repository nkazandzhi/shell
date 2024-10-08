time_to_run="$1"
shift 1
comm="$@"

echo "$comm"

starting_time=$(date +"%s.%2N")
end_time=$(echo "${starting_time} + ${time_to_run}" | bc)
command_counter=0
#echo "Start: ${starting_time} End: ${end_time}"

while [ $(echo "$(date +'%s.%2N') < ${end_time}" | bc) -eq 1 ]; do
		$@ > /dev/null		
		command_counter=$(echo "${command_counter} + 1" | bc)
done

time=$(echo "$(date +"%s.%2N") - ${starting_time}" | bc)
echo "Rann command: ${comm} ${command_counter} times in ${time} seconds"
average_time=$(echo "scale=2; $time / $command_counter" | bc)
echo "Average time: $average_time seconds" 
exit 0
