./forester build forest.toml

mv output/efr-public.json ./efr-public.json

rm -r output

./forester build public-forest.toml

echo "Adding public theme"

cp -f public-theme/* output/

rm efr-public.json

