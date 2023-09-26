source common.sh
component=backend

type npm &>>$log_file
if [ $? -ne 0 ]; then
  echo Install NodeJs Repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>$log_file
  stat_check

  echo Install NodeJs
  dnf install nodejs -y  &>>$log_file
  stat_check
fi

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service  &>>$log_file
stat_check

echo Add Application User
id expense &>>$log_file
if [ $? -ne 0 ]; then
   useradd expense  &>>$log_file
fi
stat_check

echo clean App Content
rm -rf /app   &>>$log_file
mkdir /app
cd /app
stat_check

download_and_extract

echo Download Dependencies
npm install  &>>$log_file
stat_check

echo Start Backend Service
systemctl daemon-reload  &>>$log_file
systemctl enable backend  &>>$log_file
systemctl start backend  &>>$log_file
stat_check

echo Install MYSQL Client
dnf install mysql -y  &>>$log_file
stat_check

echo Load Schema
mysql_root_password=$1
mysql -h mysql.hemanth14133.online -uroot -pmysql_mysql_root_password < /app/schema/backend.sql  &>>$log_file
stat_check