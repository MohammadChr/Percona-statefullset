sleep 20
server_id=$(echo $HOSTNAME | cut -d- -f2) && echo $server_id
if [[ server_id -eq 0 ]]; then
    mysql -uroot -proot -e "CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'password';"
    mysql -uroot -proot -e "GRANT REPLICATION SLACE ON *.* TO 'replica_user'@'%';"
    mysql -uroot -proot -e "flush privileges"
else
    mysql -uroot -proot -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='mystatefulset-0.percona', SOURCE_USER='replica_user', SOURCE_PASSWORD='password';"
fi

