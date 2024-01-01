echo -e "Create a SQL Database"

echo "Creating $SQL_SERVER_NAME in $LOCATION..."

az sql server create --name $SQL_SERVER_NAME \
--resource-group $RESOURCE_GROUP \
--location "$LOCATION" \
--admin-user $SQL_USER \
--admin-password $SQL_PASSWORD

echo "Configuring firewall..."
az sql server firewall-rule create \
--resource-group $RESOURCE_GROUP \
--server $SQL_SERVER_NAME \
-n AllowYourIp \
--start-ip-address $startIp \
--end-ip-address $endIp