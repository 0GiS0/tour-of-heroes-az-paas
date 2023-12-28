echo -e "Create a SQL Database in Azure\n"

echo "Creating $server in $location..."
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