# script to run audit while populating local host data
# 13th Sept 2021 - Initial

#!/bin/bash

BENCHMARK=CIS

# Goss Variables

AUDIT_BIN=/usr/local/bin/goss
AUDIT_FILE=goss.yml
AUDIT_VARS=vars/${BENCHMARK,,}.yml
AUDIT_CONTENT_LOCATION=/var/tmp
AUDIT_CONTENT_VERSION=Ubuntu20-$BENCHMARK-Audit
AUDIT_CONTENT_DIR=$AUDIT_CONTENT_LOCATION/$AUDIT_CONTENT_VERSION


# help output
Help()
{
   # Display Help
   echo "Script to run the goss audit"
   echo
   echo "Syntax: scriptTemplate [-g|h]"
   echo "options:"
   echo "g     optional - Add a group that the server should be grouped with"
   echo "o     optional - file to output audit data"
   echo "h     Print this Help."
   echo
}


## option statement

while getopts g:o:h option; do
   case "${option}" in
        g) GROUP=${OPTARG};;
        o) OUTFILE=${OPTARG};;
        h) # display Help
           Help
           exit;;
        \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
  esac
done

if [[ -z $GROUP ]]; then
   export auto_group="ungrouped"
   else
   export auto_group=`echo $GROUP`
fi


## System variables captured

machine_uuid=`if [ ! -z /sys/class/dmi/id/product_uuid ]; then cat /sys/class/dmi/id/product_uuid; else dmidecode -s system-uuid; fi`
epoch=`date +%s`
os_locale=`date +%Z`
os_name=`grep "^NAME=" /etc/os-release | cut -d '"' -f2 | sed 's/ //' | cut -d ' ' -f1`
os_version=`grep "^VERSION_ID=" /etc/os-release | cut -d '"' -f2`
os_hostname=`hostname`


## Set the AUDIT json string
AUDIT_JSON_VARS='{"machine_uuid":"'"$machine_uuid"'","epoch":"'"$epoch"'","os_locale":"'"$os_locale"'","audit_run":"wrapper","os_release":"'"$os_version"'","ubuntu20cis_os_distribution":"'"$os_name"'","os_hostname":"'"$os_hostname"'","auto_group":"'"$auto_group"'"}'

echo $AUDIT_JSON_VARS
exit 0

## Set AUDIT OUT
if [[ -z $OUTFILE ]]; then
   export AUDIT_OUT=$AUDIT_CONTENT_LOCATION/audit_$os_hostname_$epoch.json
else
   export AUDIT_OUT=$OUTFILE
fi


## Run pre checks

if [[ ! -s $AUDIT_BIN ]]; then
   BIN_MISSING=`echo "WARNING - The audit binary is not available at $AUDIT_BIN "`; echo $BIN_MISSING && exit 1

fi

## Run commands
#$AUDIT_BIN -g $AUDIT_CONTENT_DIR/$AUDIT_FILE --vars $AUDIT_CONTENT_DIR/$AUDIT_VARS  --vars-inline $AUDIT_JSON_VARS v -f json -o pretty
$AUDIT_BIN -g $AUDIT_CONTENT_DIR/$AUDIT_FILE --vars $AUDIT_CONTENT_DIR/$AUDIT_VARS  --vars-inline $AUDIT_JSON_VARS v -f json -o pretty > $AUDIT_OUT

# create screen output
if [[ `grep -c $BENCHMARK $AUDIT_OUT` > 0 ]]; then
   echo  "Success Audit
`tail -7 $AUDIT_OUT`
Completed file can be found at $AUDIT_OUT"
else
  echo "Fail Audit - There were issues when running the audit please investigate $AUDIT_OUT"
fi