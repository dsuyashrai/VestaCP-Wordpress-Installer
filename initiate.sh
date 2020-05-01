#!/bin/bash
wget "https://wordpress.org/latest.zip" -O vestacp_wp_temp.zip
rm index.html
rm robots.txt
rm index.html.original
unzip vestacp_wp_temp.zip
mv wordpress/* ./
rmdir wordpress
rm vestacp_wp_temp.zip
mv wp-config-sample.php wp-config.php
echo "Enter DB Host: "
read db_hostname
echo "Enter DB Name: "
read database_name
echo "Enter DB Username: "
read db_username
echo "Enter DB Password: "
read db_password
echo "Enter Table Prefix (eg. my_): "
read tbl_prefix

sed -i "s/database_name_here/$database_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_password/g" wp-config.php
sed -i "s/localhost/$db_hostname/g" wp-config.php
sed -i "s/$table_prefix = 'wp_'/$table_prefix = '$tbl_prefix'/g" wp-config.php

if grep -q "^define( 'FS_METHOD'" wp-config.php
then
  :
else
   sed -i "/^define( 'WP_DEBUG'.*/a define( 'FS_METHOD', 'direct' );" wp-config.php
fi

