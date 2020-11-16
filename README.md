# Check-Updated-Websites-Script

**Idea of the project**

The purpose of this project is to create a bash script that reads a list with some websites and checks if some of them have been updated since the last time the script was run.
The list with the websites will be in a simple .txt file which will be given as a parameter in the script.

**Example of the .txt file:**
# List of addresses
http :// www.tldp.org
https ://en.wikipedia.org/wiki/Linux
https :// www.gnu.org/software/bash/

There is no limit in the number of websites contained in the .txt file. If a line begins with # it should be considered a comment so it should be ignored. 
Running the script, it must read the websites and check if any of them has been updated. If a website remained the same as last time the script shouldn't print something. If the contents of a website have changed, the script must print in the default output stream (stdout) the url of the website. For example: 
http :// www.tldp.org
If the script reads a website for the first time, it must print in the default output stream (stdout) the url of the website along with the message INIT. For example:
http :// www.tldp.org INIT
If for any reason the script can't read the contents of a website (for whatever reason), it must print in the default error output stream (stderr) the url of the website along with the message FAILED. For example:
http :// www.tldp.org FAILED

There are 2 versions of the script. Script *script1a.sh* reads the websites successively and script *script1b.sh* reads the websites at the same time.

This project was created for a 5th semester course.


*The idea of this project belongs to its respectful owner*
*Operating Systems - AUTH 2018*
