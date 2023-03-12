sleep 60
server_id=$(echo $HOSTNAME | cut -d- -f2) && echo $server_id
if [[ server_id -eq 0 ]]; then
    mysql -uroot -proot -e "CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'password';"
    mysql -uroot -proot -e "GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';"
    mysql -uroot -proot -e "FLUSH PRIVILEGES"
else
    mysql -uroot -proot -e "CHANGE MASTER TO MASTER_HOST='mystatefulset-0.percona', MASTER_USER='replica_user', MASTER_PASSWORD='password';"
fi


