if [[ $HEAD -eq "develop" ]]
then
	curl https://circleci.com/api/v1.1/project/github/ricelectronics/BMS/latest/artifacts?circle-token=$CIRCLE_TOKEN \
	| grep -o 'https://[^"]*' \
	| grep -o -E 'https.+docs_develop.tar.xz$' \
	| wget --verbose --header "Circle-Token: $CIRCLE_TOKEN" -O docs.tar.xz -v -i -
elif [[ $HEAD -eq "main" ]]
then
	curl https://circleci.com/api/v1.1/project/github/ricelectronics/BMS/latest/artifacts?circle-token=$CIRCLE_TOKEN \
	| grep -o 'https://[^"]*' \
	| grep -o -E 'https.+docs_master.tar.xz$' \
	| wget --verbose --header "Circle-Token: $CIRCLE_TOKEN" -O docs.tar.xz -v -i -
else
	echo "Unknown branch $HEAD"
	exit 1
fi

tar -Jxf docs.tar.xz
cp index.html doc/index.html