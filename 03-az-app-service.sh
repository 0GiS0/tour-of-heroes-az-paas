echo -e "Create Azure App Service for the API 🚀"

echo "Creating $APP_SVC_PLAN_NAME in $LOCATION..."
az appservice plan create \
--name $APP_SVC_PLAN_NAME \
--resource-group $RESOURCE_GROUP \
--location $LOCATION \
--sku S1

echo "Creating $WEB_API_NAME in $LOCATION..."
az webapp create \
--name $WEB_API_NAME \
--resource-group $RESOURCE_GROUP \
--plan $APP_SVC_PLAN_NAME \
--deployment-local-git

echo "Configuring $WEB_API_NAME..."
az webapp config connection-string set \
--name $WEB_API_NAME \
--resource-group $RESOURCE_GROUP \
--connection-string-type SQLAzure \
--settings "DefaultConnection=Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=heroes-db;Persist Security Info=False;User ID=$SQL_USER;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

echo "Clone the repo..."
git clone https://github.com/0GiS0/tour-of-heroes-dotnet-api.git
cd tour-of-heroes-dotnet-api

dotnet publish tour-of-heroes-api.csproj -c Debug -o ./publish

cd publish

az webapp up \
-n $WEB_API_NAME \
-g $RESOURCE_GROUP \
--launch-browser
