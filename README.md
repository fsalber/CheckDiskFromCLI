# Disk usage and alert from CLI

This little script allow you to check disk usage of a particular folder and send you alert by email.

### Requirements 

This script require : 

- Debian, Ubuntu
- A mail server, which allow you to send email from your server

### 1. Installation

First, clone this repo :

```sh
git clone https://github.com/fsalber/CheckDiskFromCLI.git
```

### 2. Usage

For use this script, you have first to give him the correct rights

```sh
chmod a+x script.sh
```

then, you can use it just using this command : 

```sh
./script.sh *MY FOLDER PATH* *MAX FOLDER SIZE* *WARM FOLDER SIZE*
```

Parameters : 

- MY FOLDER PATH : Absolute path from /
- MAX FOLDER SIZE : Max folder size in Mb
- WARM FOLDER SIZE : Warm size in Mb

The script will create a log file into the folder "/var/logs/custom/quota/"
He will send you a mail (don't forget to edit "you@domain.tld" which is the destination mail) when : 

- The folder size is between the Max size and the Warm size
- The folder size is equal to the Max size
- The folder size is bigger than the Max size

Feel free to adapt the script as you want.

### 3. Notice

Btw : Every text is written in french, you can translate it as you want

You can add a crontab line for the script. 
In my example, the script will be called every day at 00:00

```sh
0 0 * * * ./script.sh MYFOLDERPATH MAXFOLDERSIZE WARMFOLDERSIZE >/dev/null 2>&1
```


### 4. Support

If you have any problems with this script, feel free to open a issues. We will try to find out a solution ;)