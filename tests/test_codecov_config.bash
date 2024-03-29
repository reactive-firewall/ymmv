#! /bin/bash
# checks if the codcov.yml file is valid
# exit fast if command is missing
EXIT_CODE=0 ;
test -f "${1:-.codecov.yml}" || exit $EXIT_CODE ;
if [[ ( $(curl --tlsv1.2 --header "Dnt: 1" -fsS --data-binary "@${1:-.codecov.yml}" https://codecov.io/validate 2>/dev/null | fgrep -c "Valid" ) -gt 0) ]] ; then
	EXIT_CODE=0 ;
else
	EXIT_CODE=1 ;
fi
#if [[ ( $EXIT_CODE -gt 0 ) ]] ; then
#	echo "FAIL: codecov.yml validation FAILED." ;
#else
#	echo "Ok: codecov.yml validation passed." ;
#fi
exit ${EXIT_CODE:255} ;
