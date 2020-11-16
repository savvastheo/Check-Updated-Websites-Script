#!/bin/bash
#Files containing the source code of websites are being arranged based on the name of the website(removing special characters like : / . ? etc)
#Parallel checking

INPUT=$1

checkWebsite(){
	websiteToCheck=$1
	FLAG=false

		while IFS= read -r lineOfPrev && [[ "$FLAG" == false ]]
		do
			if [[ "$websiteToCheck" ==  "$lineOfPrev" ]] #lineOfPrev --> name of the website in the previousWebsites.txt 
			then
				fileName=$(echo "$websiteToCheck" | tr -d :/."?"="&"^+-_)
				wget -q -O temp_"$fileName".txt "$websiteToCheck" || (echo "$websiteToCheck FAILED" >&2 & rm temp_"$fileName".txt) #>&2 redirect output to stderr
				if [[ -e temp_"$fileName".txt ]];
				then
					DIFF=$(diff temp_"$fileName".txt "$fileName".txt)
					if [ "$DIFF" != "" ];
					then
				 		echo "$websiteToCheck"
				 		mv temp_"$fileName".txt "$fileName".txt
					else
						rm temp_"$fileName".txt
					fi
				fi
				FLAG=true
			fi
		done < "$prevInput"

		if [[ "$FLAG" == false ]] #first time downloading a website
		then
			fileName=$(echo "$websiteToCheck" | tr -d :/."?"="&"^+-_)
			(wget -q -O "$fileName".txt "$websiteToCheck" && echo "$websiteToCheck INIT" && echo "$websiteToCheck" >> previousWebsites.txt) || (echo "$websiteToCheck FAILED" >&2 & rm "$fileName".txt)
		fi
}

if [[ ! -e previousWebsites.txt ]];
	then
		touch previousWebsites.txt
fi
prevInput=previousWebsites.txt

while IFS= read -r line
do
	if [[ "$line" != "#"* ]] #ignore comments
	then
		checkWebsite "$line" &
	fi
done < "$INPUT"
