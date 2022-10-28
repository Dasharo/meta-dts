#!/usr/bin/env bash

CLOUD_DOWNLOAD_URL=""
CLOUD_PASSWORD=""
USER_DETAILS="$CLOUD_DOWNLOAD_URL:$CLOUD_PASSWORD"
CLOUD_REQUEST="X-Requested-With: XMLHttpRequest"

tmpURL="https://cloud.3mdeb.com/public.php/webdav/"

curl -f -u "$USER_DETAILS" -H "$CLOUD_REQUEST" -X PROPFIND "$tmpURL" -o webdav_response

sed -ie 's/\://g' webdav_response
sed -ie 's/\?//g' webdav_response

sed -i 's/<dresponse>/&\n&\n<dresponse>/g' webdav_response
sed -i 's/<&/dresponse>/<&/dresponse>&\n/g' webdav_response

cat webdav_response | grep public.php/webdav/ > list

# remove xml tags
sed -i 's/dresponse//g' list
sed -i 's/dhref//g' list
sed -i 's/dpropstat//g' list
sed -i 's/dprop//g' list
sed -i 's/dgetlastmodified//g' list
sed -i 's/dresourcetype//g' list
sed -i 's/dcollection//g' list
sed -i 's/dstatus//g' list
sed -i 's/dmultistatus//g' list
sed -i 's/dquota-available-bytes//g' list
sed -i 's/dquota-used-bytes//g' list
sed -i 's/dgetcontenttype//g' list
sed -i 's/dgetcontentlength//g' list
sed -i 's/dgetetag//g' list

sed -ie 's/[<>]//g' list
sed -ie 's/\GMT.*/GMT/' list
sed -ie 's/.*webdav/?/' list
sed -ie 's/\?//g' list

echo -e "\n\nRESULT:"
cat list
