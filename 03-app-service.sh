echo -e "Create Azure App Service for the API 🚀"

az appservice plan create \
--name $APP_SVC_PLAN_NAME \
--resource-group $RESOURCE_GROUP \
--location $LOCATION \
--sku S1

az webapp create \
--name $WEB_API_NAME \
--runtime "dotnet:8" \
--resource-group $RESOURCE_GROUP \
--plan $APP_SVC_PLAN_NAME

az webapp config connection-string set \
--name $WEB_API_NAME \
--resource-group $RESOURCE_GROUP \
--connection-string-type SQLAzure \
--settings "DefaultConnection=Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=heroes-db;Persist Security Info=False;User ID=$SQL_USER;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az webapp config appsettings set \
--name $WEB_API_NAME \
--resource-group $RESOURCE_GROUP \
--settings "OTEL_SERVICE_NAME=tour-of-heroes-api"


echo "Clone the repo..."
git clone https://github.com/0GiS0/tour-of-heroes-dotnet-api.git
cd tour-of-heroes-dotnet-api

dotnet publish tour-of-heroes-api.csproj -o ./publish

cd publish

zip -r site.zip *

az webapp deployment source config-zip \
--src site.zip \
--resource-group $RESOURCE_GROUP \
--name $WEB_API_NAME

echo "API deployed 🚀"
echo "API URL: https://$WEB_API_NAME.azurewebsites.net"