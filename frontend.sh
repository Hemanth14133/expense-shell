source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y   &>>$log_file
echo $?

echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf  &>>$log_file
echo $?

echo Removing Old Nginx Content
rm -rf /usr/share/nginx/html/*  &>>$log_file
echo $?

cd /usr/share/nginx/html
echo $?

download_and_extract
echo $?

echo starting Nginx Service
systemctl enable nginx   &>>$log_file
systemctl restart nginx  &>>$log_file
echo $?