#!/bin/bash

set -e

# Path variables
BENCH_PATH="/workspaces/frappe_codespace/frappe-bench"
SITE_NAME="dev.localhost"
WORKSHOP="workshop"
# Check if bench already exists
if [[ -d "$BENCH_PATH/apps/frappe" ]]; then
    echo "Bench already exists, skipping init."
    exit 0
fi

# Clean up .git directory if not needed
if [[ -d "/workspaces/frappe_codespace/.git" ]]; then
    rm -rf /workspaces/frappe_codespace/.git
fi

# Set up Node environment with NVM
source /home/frappe/.nvm/nvm.sh
if [[ $(nvm current) != "v18" ]]; then
    nvm install 18
    nvm alias default 18
    echo "nvm use 18" >> ~/.bashrc
fi
nvm use default

# Ensure yarn is installed
if ! command -v yarn &> /dev/null; then
    echo "Yarn not found, installing..."
    npm install -g yarn
fi
# Initialize Frappe bench
cd /workspace
bench init --ignore-exist --skip-redis-config-generation frappe-bench
cd frappe-bench

# Configure bench to use containerized services
bench set-mariadb-host mariadb
bench set-redis-cache-host redis-cache:6379
bench set-redis-queue-host redis-queue:6379
bench set-redis-socketio-host redis-socketio:6379

# Remove Redis from Procfile if listed
sed -i '/redis/d' ./Procfile

# Check if the site already exists
bench new-site $SITE_NAME --mariadb-user-host-login-scope='%' --admin-password='123' --db-root-username=root --db-root-password='123'
bench --site $SITE_NAME set-config developer_mode 1
bench --site $SITE_NAME clear-cache
bench use $SITE_NAME


#All repositories that will be installed. Format is 
#RepoURL, App Name, Branch
repositories=(
 "https://github.com/Altrix-One/frappe frappe version-15"
)


# Loop through the array and process each entry
for repo_info in "${repositories[@]}"; do
    # Split the entry into variables
    repo_url=$(echo "$repo_info" | awk '{print $1}')
    extracted_text=$(echo "$repo_info" | awk '{print $2}')
    branch=$(echo "$repo_info" | awk '{print $3}')
    bench get-app --resolve-deps $extracted_text $repo_url --branch $branch
done

for repo_info in "${repositories[@]}"; do
    # Split the entry into variables
    repo_url=$(echo "$repo_info" | awk '{print $1}')
    extracted_text=$(echo "$repo_info" | awk '{print $2}')
    branch=$(echo "$repo_info" | awk '{print $3}')
    # Example command or operation
    if ! bench --site $SITE_NAME list-apps | grep -q $extracted_text; then
        bench --site $SITE_NAME install-app $extracted_text
    fi
done
