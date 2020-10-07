#!/bin/bash
#modifier par le dossier contenant les dossiers gits
repogit="~/git/"


green="\e[32m"
blue="\e[34m"
orange="\e[33m"
red="\e[31m"
location="$PWD"
fail ()
{
echo -e "$red""echec du script"
exit 0
}

while IFS= read -r -d '' ligne
do
cd "$location" || fail
cd "$ligne" || fail
cd .. || fail
echo -e ""
echo -e "$green""--------------------------------------------"
url=$(git config --get remote.origin.url)
statusshort=$(git status --short)
branch=$(git rev-parse --abbrev-ref HEAD)
ajour=$(git status | grep ^Votre | grep -v jour)
echo -e "$green""$(pwd)"
echo -e "$blue""$url"
if [[ -n "$statusshort" ]]
then
echo -e "$orange""$statusshort"
fi
if [[ $branch != "master" && $branch != "develop" ]]
then
echo -e "$orange""$branch"
else
echo -e "$blue""$branch"
fi
if [[ -n "$ajour" ]]
then
echo -e "$orange""$ajour"
fi
if [[ -z "$ajour" && -z "$statusshort" ]]
then
echo -e "$blue""pull automatique\e[0m"
git pull
else
echo -e "$red""maj manuelle a faire, risque de merge"
fi
echo -e "$green""--------------------------------------------"
done <   <(find "$repogit" -name '.git' -type d -print0 | sort -z) 
echo -e "\e[39m""fin du script"
cd "$location" || fail

