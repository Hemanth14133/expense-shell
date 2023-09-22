source common.sh
component=backend

echo Install NodeJs Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>$log_file
echo $?

echo Install NodeJs
dnf install nodejs -y  &>>$log_file
echo $?

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service  &>>$log_file
echo $?

echo Add Application User
useradd expense  &>>$log_file
echo $?

echo clean App Content
rm -rf /app   &>>$log_file
mkdir /app
cd /app
echo $?

download_and_extract
echo $?

echo Download Dependencies
npm install  &>>$log_file
echo $?

echo Start Backend Service
systemctl daemon-reload  &>>$log_file
systemctl enable backend  &>>$log_file
systemctl restart backend  &>>$log_file
echo $?

echo Install MYSQL Client
dnf install mysql -y  &>>$log_file
echo $?

echo Load Schema
mysql -h mysql.hemanth14133.online -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>$log_file
echo $?