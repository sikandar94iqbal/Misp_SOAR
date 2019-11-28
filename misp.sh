#!/bin/bash


event_id=$1

#echo $event_id


#echo $event_id
sleep 15
event=`curl --insecure -s --header "Authorization: gnZhjzbZWvnkLD4PkI7JbzOIb0oRdL6dMEwzsggV" --header "Accept: application/json" --header "Content-Type: application/json" https://192.168.1.251/events/view/$event_id | jq '.Event'`

#echo $event

event_id_new=`echo $event | jq '.id'`
info=`echo $event | jq '.info'`
echo "this is eventID: " $event_id_new

attribute=`echo $event | jq '.Attribute'`

echo "this is full attribute :\n"
echo $attribute
data=`echo $attribute | jq '.[].data'`


echo "this is data : \n"

temp="${data%\"}"
temp="${temp#\"}"
echo "$temp"

echo $temp

echo "this is info (title of case) : \n"
echo $info
#echo $data




post_data='{"title":'$info',"description":'$info'}'

echo $post_data > post.json

# Curl to add event in misp
case_data=`curl -XPOST -H 'Authorization: Bearer BikxZhTHusorvjK5TDhhvU2+wwi2YQz4' -H 'Content-Type: application/json' http://192.168.0.110:9000/api/case -d@post.json`

#curl --insecure --header "Authorization: gnZhjzbZWvnkLD4PkI7JbzOIb0oRdL6dMEwzsggV" --header "Accept: application/json" --header "Content-Type: application/json" https://192.168.1.251/events/281
#echo $id['data']


obs=`openssl enc -base64 -d <<< $temp`

echo "\n"



source_ip=`echo $obs | jq '.source_ip'`



#url=`echo $obs | jq '.url'`



#url1="${url%\"}"
#url1="${url1#\"}"
#echo "$url1"


temp1="${source_ip%\"}"
temp1_ip="${temp1#\"}"
echo "$temp1_ip"




echo "this is case data"
case_id1=`echo $case_data | jq '.id'`


temp2="${case_id1%\"}"
case_id="${temp2#\"}"
echo "$case_id"






obs_data='{"dataType":"ip","data":"'$temp1_ip'","message":"idk"}'
#obs_data2='{"dataType":"url","data":"'$url1'","message":"this url is suspecious"}'


echo $obs_data > obs.json
#echo $obs_data2 > obs2.json



#add ip  observable
curl -XPOST -H 'Authorization: Bearer BikxZhTHusorvjK5TDhhvU2+wwi2YQz4' -H 'Content-Type: application/json' http://192.168.0.110:9000/api/case/$case_id/artifact -d@obs.json



#if [ -z "$url" ]
#then
#echo "url is empty not adding obs"
#else
#echo "url not empty"
#add url observable
#curl -XPOST -H 'Authorization: Bearer BikxZhTHusorvjK5TDhhvU2+wwi2YQz4' -H 'Content-Type: application/json' http://192.168.0.110:9000/api/case/$case_id/artifact -d@obs2.json

#fi

