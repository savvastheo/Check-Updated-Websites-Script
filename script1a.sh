#!/bin/bash
#Files containing the source code of websites are being arranged based on the number of the line found in websites.txt
#Linear checking

INPUT=$1

checkWebsite(){
	websiteToCheck=$1
	SITE_INDEX=1
	FLAG=false

		while IFS= read -r lineOfPrev && [[ "$FLAG" == false ]]
		do
			if [[ "$websiteToCheck" ==  "$lineOfPrev" ]] #lineOfPrev --> name of the website in the previousWebsites.txt 
			then
				wget -q -O temp_"$SITE_INDEX".txt "$websiteToCheck" || (echo "$websiteToCheck FAILED" >&2 & rm temp_"$SITE_INDEX".txt) #>&2 redirect output to stderr
				if [[ -e temp_"$SITE_INDEX".txt ]];
				then
					DIFF=$(diff temp_"$SITE_INDEX".txt "$SITE_INDEX".txt)
					if [ "$DIFF" != "" ];
					then
				 		echo "$websiteToCheck"
				 		mv temp_"$SITE_INDEX".txt "$SITE_INDEX".txt
					else
						rm temp_"$SITE_INDEX".txt
					fi
				fi
				FLAG=true
				SITE_INDEX=1
			else
				SITE_INDEX=$((SITE_INDEX + 1))
			fi
		done < "$prevInput"

		if [[ "$FLAG" == false ]] #first time downloading a website
		then
			(wget -q -O "$SITE_INDEX".txt "$websiteToCheck" && echo "$websiteToCheck INIT" && echo "$websiteToCheck" >> previousWebsites.txt) || (echo "$websiteToCheck FAILED" >&2 & rm "$SITE_INDEX".txt)
			SITE_INDEX=1
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
		checkWebsite "$line" 
	fi
done < "$INPUT"