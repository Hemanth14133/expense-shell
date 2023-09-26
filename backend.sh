source common.sh
component=backend

echo Install NodeJs Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>>$log_file
if [ $? -eq 0 ]; then
  echo -e"\e[32mSUCCESS\e[0m"
else
  echo -e"\e[31mFAILED\e[0m"
fi

echo Install NodeJs
dnf install nodejs -y  &>>$log_file
if [ $? -eq 0 ]; then
  echo -e"\e[32mSUCCESS\e[0m"
else
  echo -e"\e[31mFAILED\e[0m"
fi

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service  &>>$log_file
if [ $? -eq 0 ]; then
  echo -e"\e[32mSUCCESS\e[0m"
else
  echo -e"\e[31mFAILED\e[0m"
fi

echo Add Application User
useradd expense  &>>$log_file
if [ $? -eq 0 ]; then
  echo -e"\e[32mSUCCESS\e[0m"
else
  echo -e"\e[31mFAILED\e[0m"
fi

echo clean App Content
rm -rf /app   &>>$log_file
mkdir /app
cd /app
if [ $? -eq 0 ]; then
  echo -e"\e[32mSUCCESS\e[0m"
else
  echo -e"\e[31mFAILED\e[0m"
fi

download_and_extract

echo Download Dependencies
npm install  &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Start Backend Service
systemctl daemon-reload  &>>$log_file
systemctl enable backend  &>>$log_file
systemctl restart backend  &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Install MYSQL Client
dnf install mysql -y  &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Load Schema
mysql -h mysql.hemanth14133.online -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi