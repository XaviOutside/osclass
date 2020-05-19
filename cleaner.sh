VOLUME_PATH=$(docker inspect -f '{{ (index .Mounts 1).Source }}' osclass_osclass_1)

rm ${VOLUME_PATH}/oc-content/debug.log 
find ${VOLUME_PATH}/oc-content/uploads/temp -name "qqfile*" -ctime -24 -exec rm -f {} \;
find ${VOLUME_PATH}/oc-content/uploads/temp -name "auto_qqfile*" -ctime -24 -exec rm -f {} \;

