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
echo $data

echo "this is info (title of case) : \n"
echo $info
#echo $data


#curl --insecure --header "Authorization: gnZhjzbZWvnkLD4PkI7JbzOIb0oRdL6dMEwzsggV" --header "Accept: application/json" --header "Content-Type: application/json" https://192.168.1.251/events/281
#echo $id['data']
