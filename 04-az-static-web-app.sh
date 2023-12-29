echo -e "Create Azure Static Web App 🚀"

az staticwebapp create \
--name tour-of-heroes-web \
--resource-group $RESOURCE_GROUP \
--source https://github.com/$GITHUB_USER_NAME/tour-of-heroes-angular \
--location $LOCATION \
--branch main \
--app-location "src" \
--login-with-github

# https://azure.github.io/static-web-apps-cli/