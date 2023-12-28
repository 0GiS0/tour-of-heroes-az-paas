echo -e "Create Azure App Service for the API 🚀"

echo "Creating $APP_SVC_PLAN_NAME in $LOCATION..."
az appservice plan create \
--name $APP_SVC_PLAN_NAME \
--resource-group $RESOURCE_GROUP \
--location $LOCATION \
--sku S1

echo "Creating $WEB_APP_NAME in $LOCATION..."
az webapp create \
--name $WEB_APP_NAME \
--resource-group $RESOURCE_GROUP \
--plan $APP_SVC_PLAN_NAME \
--deployment-local-git

echo "Configuring $WEB_APP_NAME..."
# az webapp config appsettings set \
# --name $WEB_APP_NAME \
# --resource-group $RESOURCE_GROUP \
# --settings 
