#!bin/bash

set -e
set -x

if [[ -f "/workspaces/frappe_codespace/frappe-bench/apps/frappe" ]]
then
    echo "Bench already exists, skipping init"
    exit 0
fi

rm -rf /workspaces/frappe_codespace/.git

source /home/frappe/.nvm/nvm.sh
nvm alias default 18
nvm use 18

echo "nvm use 18" >> ~/.bashrc
cd /workspace

bench init \
--ignore-exist \
--skip-redis-config-generation \
frappe-bench

cd frappe-bench

# Use containers instead of localhost
bench set-mariadb-host mariadb
bench set-redis-cache-host redis-cache:6379
bench set-redis-queue-host redis-queue:6379
bench set-redis-socketio-host redis-socketio:6379

# Remove redis from Procfile
sed -i '/redis/d' ./Procfile


bench new-site dev.altrixone --mariadb-user-host-login-scope='%' --admin-password='123' --db-root-username=root --db-root-password='123'
bench --site dev.altrixone set-config developer_mode 1
bench --site dev.altrixone clear-cache
bench use dev.altrixone
bench get-app https://github.com/fossunited/fossunited --branch develop
bench --site dev.altrixone install-app fossunited