#!/bin/bash

set -e

CURRENT_NAME="Mudala"
CURRENT_OTP="mudala"

NEW_NAME="Mudala"
NEW_OTP="mudala"

ack -l $CURRENT_NAME --ignore-file=is:rename_phoenix_project.sh | xargs sed -i '' -e "s/$CURRENT_NAME/$NEW_NAME/g"
ack -l $CURRENT_OTP --ignore-file=is:rename_phoenix_project.sh | xargs sed -i '' -e "s/$CURRENT_OTP/$NEW_OTP/g"

mv lib/$CURRENT_OTP lib/$NEW_OTP
mv lib/$CURRENT_OTP.ex lib/$NEW_OTP.ex
mv lib/${CURRENT_OTP}_web lib/${NEW_OTP}_web
mv lib/${CURRENT_OTP}_web.ex lib/${NEW_OTP}_web.ex
mv test/$CURRENT_OTP test/$NEW_OTP
mv test/${CURRENT_OTP}_web test/${NEW_OTP}_web
