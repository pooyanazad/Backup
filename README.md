# Backup
Backup full script</br>
```
apt install git
git clone https://github.com/pooyanazad/Backup.git
chmod +x backup.sh
```
You should change below information with your requests in "config.sh" file</br>
- set your backup source
- set your backup destination
- set your backup log path
- set your backup saving days
- set your backup compressing level</br>
</br>
./backup.sh or use it on crontab like me : 5 0 * * * /mnt/backup.sh 
</br>
This application is my production daily backup script and it will keep your last 5 days backup also added some function to keep every 15th of month backup for 2 years as a monthly backup</br>
</br>
I want to add some fetures to this script with your help and idea:</br>

- Add email part to sent notification if process goes fail (we can use and API or some linux package and send directly)
- You can share your idea!</br>
</br>
You can find me: Pooyan.azadparvar@gmail.com </br>
