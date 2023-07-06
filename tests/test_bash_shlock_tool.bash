#! /bin/bash

#FIXME: add header

LOCK_FILE="/tmp/test_$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM.lock" ;

if [[ ( $(./.github/tool_shlock_helper.sh -f ${LOCK_FILE} -p $$ ) -eq 0 ) ]] ; then
#echo "locked" ;
echo "OK" ;
else
echo "FAIL" >&2 ;
fi ;
#ls -1 "${LOCK_FILE}" ;

unlink "${LOCK_FILE}" ; wait ;

#echo ""
exit 126 ;