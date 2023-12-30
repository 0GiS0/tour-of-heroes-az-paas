echo -e "Create Azure Static Web App 🚀"

az staticwebapp create \
--name $WEB_APP_NAME \
--resource-group $RESOURCE_GROUP \
--source https://github.com/$GITHUB_USER_NAME/tour-of-heroes-angular \
--location "westeurope" \
--branch main \
--app-location "/" \
--output-location "dist/angular-tour-of-heroes" \
--login-with-github

# https://azure.github.io/static-web-apps-cli/