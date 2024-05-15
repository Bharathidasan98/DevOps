#!/bin/bash
#
## Specify the file to read
file="/Users/Bharathidasan.m/mydiary/terraform/infra_notifs.txt"
#
## Initialize count variables
#error_count=0
#query_result_count=0
#
## Check if the file exists
#if [ -f "$file" ]; then
#    # Read each line from the file
#    while IFS= read -r line; do
#        # Check if the line contains the word "Error"
#        if [[ "$line" == *Error* ]]; then
#            # Increment error count
#            ((error_count++))
#            # Print the line
#            echo "$line"
#        # Check if the line contains the phrase "query result"
#        elif [[ "$line" == *"query result"* ]]; then
#            # Increment query result count
#            ((query_result_count++))
#            # Print the line
#            echo "$line"
#        fi
#    done < "$file"
#
#    # Print the counts
#    echo "Error count: $error_count"
#    echo "Query result count: $query_result_count"
#else
#    echo "File $file does not exist."
#fi
#
#!/bin/bash

# Specify the file to read
#file="filename.txt"

# Initialize count variables
error_count=0
query_result_count=0
down_count=0
Nimesa_count=0
Apdex_count=0
Exception_count=0
found_impaired_count=0
Failed_count=0



# Variable to store the previous line
previous_line=""

# Check if the file exists
if [ -f "$file" ]; then
    # Read each line from the file
    while IFS= read -r line; do
        # Check if the line contains the word "Error"
        if [[ "$line" == *rror* ]]; then
            # Increment error count
            ((error_count++))
            # Print the line
            echo "$line" >> output.csv
        # Check if the line contains the phrase "query result"
        elif [[ "$line" == *"query result"* ]]; then
            # Increment query result count
            ((query_result_count++))
            # Print the line
            echo "$line" >> output.csv
        elif [[ "$line" == *"found impaired"* ]]; then
            # Increment query result count
            ((found_impaired_count++))
            # Print the line
            echo "$line" >> output.csv
        elif [[ "$line" == *"Exception"* ]]; then
            # Increment query result count
            ((Exception_count++))
            # Print the line
            echo "$line" >> output.csv
        elif [[ "$line" == *"Apdex"* ]]; then
            # Increment query result count
            ((Apdex_count++))
            # Print the line
            echo "$line" >> output.csv
        elif [[ "$line" == *"down"* ]]; then
            # Increment query result count
            ((down_count++))
            # Print the line
            echo "$line" >> output.csv
        elif [[ "$line" == *"Nimesa"* ]]; then
            # Increment query result count
            ((Nimesa_count++))
            # Print the line
            echo "$line" >> output.csv
        elif [[ "$line" == *"Failed"* ]]; then
            # Increment query result count
            ((Failed_count++))
            # Print the line
            echo "$line" >> output.csv
        # Compare current line with the previous line
        elif [ "$line" == "$previous_line" ]; then
            echo "The current line is the same as the previous line: $line"
        fi
        # Store the current line as the previous line for the next iteration
        previous_line="$line"
    done < "$file"
 cat output.csv
    # Print the counts
    echo "Error count: $error_count"
    echo "Query result count: $query_result_count"
    echo "Apdex count: $Apdex_count"
    echo "Exception_count: $Exception_count"
    echo "down_alert: $down_count"
    echo "Nimesa_count : $Nimesa_count"
    echo "found_impaired_count: $found_impaired_count"

else
    echo "File $file does not exist."
fi
