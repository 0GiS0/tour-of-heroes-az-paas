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
az webapp config appsettings set \
--name $WEB_APP_NAME \
--resource-group $RESOURCE_GROUP \
--settings "DefaultConnection=Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=heroes-db;Persist Security Info=False;User ID=$SQL_USER;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

echo "Clone the repo..."
git clone https://github.com/0GiS0/tour-of-heroes-dotnet-api.git
cd tour-of-heroes-dotnet-api

echo "Deploy the API in Azure App Service..."
git remote add azure $(az webapp deployment source config-local-git \
--name $WEB_APP_NAME \
--resource-group $RESOURCE_GROUP \
--query url --output tsv)

git push azure master
