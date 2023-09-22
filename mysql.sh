source common.sh

echo Disable MySQL 8 Version
dnf module disable mysql -y &>>$log_file
echo $?
echo Copy MySQL Repo File
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?
echo install MySQL server
dnf install mysql-community-server -y  &>>$log_file
echo $?
echo Start MySQL Service
systemctl enable mysqld &>>$log_file
systemctl start mysqld  &>>$log_file
echo $?
echo Setup Root Password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
echo $?
