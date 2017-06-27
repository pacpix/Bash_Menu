#!/bin/bash

option="a"

#main while loop for the program
while [ $option != "e" ]
do    
    echo "a. Append line numbers to a text file."
    echo "b. Remove line numbers from a text file."
    echo "c. Remove any and all underscores from a given file name."
    echo "d. Backup files and directories into a special sub-directory called \" .backup \"."
    echo "e. Exit."
    read -p "Please Choose an Option: " option #takes user selection

    if [ $option == "a" ] 
    then
        read -p "Please enter a file name: " file
        if [ -f "$file" ]
        then
            nl  -s " - " $file > outputfile #nl utility adds line numbers to file
            mv outputfile $file #Copies over old file with file with line numbers
        else
            echo "File does not exist."
        fi
    fi

    if [ $option == "b" ]
    then
        read -p "Please enter a file name: " file
        if [ -f "$file" ]
        then
            sed 's/^ *[0-9]\+...//g' $file > outputfile #sed regex expression removes the line numbers
            mv outputfile $file #Copies over old file with new file without line numbers
        else
            echo "File does not exist."
        fi
    fi

    if [ $option == "c" ]
    then
        read -p "Please enter a file name: " file
        if [ -f "$file" ]
        then
            mv "$file" "${file//_/}" #Command removes underscores from the name
        else
            echo "File does not exist."
        fi
    fi

    if [ $option == "d" ] 
    then
        read -p "Enter 1 for directory or 2 for file: " backupchoice #takes user input to determine whether a directory or a file is being backed up
        if [ $backupchoice == "1" ] #Directory case
        then
            read -p "Please enter a directory name: " directory
            if [ -d ".backup" ]
            then
                if [ -d "$directory" ]
                then
                    cp -r $directory .backup 
                else
                    echo "Directory does not exist."
                fi
            else
                echo "Backup folder was not found, thus is has been created"
                mkdir .backup
                if [ -d "$directory" ]
                then
                    cp -r $directory .backup
                else
                    echo "Directory does not exist."
                fi
            fi
        fi
        if [ $backupchoice == "2" ] #File case
        then 
            read -p "Please enter a file name: " file
            if [ -d ".backup" ]
            then
                if [ -f "$file" ]
                then
                    cp $file .backup
                else
                    echo "File does not exist."
                fi
            else
                echo "Backup folder was not found, thus it has been created"
                mkdir .backup
                if [ -f "$file" ]
                then
                    cp $file .backup
                else
                    echo "File does not exist."
                fi
            fi
        fi
    fi

done
echo "Thank you.  Exiting now..."
