#!/bin/bash

LFTP=`which lftp` || exit "Can't find lftp"
SITE=ftp://admin@example.com

show_help()
{
    echo "This script will mirror, using lftp, the site."
    echo ""
    echo -e "-h\t\tthis message"
    echo -e "-v\t\tverbose output"
    echo -e "-d\t\tdelete files not present at remote site"
    echo -e "-r\t\treverse mirror (put files)"
    echo -e "-s\t\tsimulate operations"
}

run()
{
    command="$1 ; quit"

    ${LFTP} ${SITE} -e "${command}"
}

OPTIND=1
delete=""
verbose=""
reverse=""
dryrun=""

BASEDIR=$(pwd)
TARGETDIR="/public_html/blog"
OUTPUTDIR=${BASEDIR}/output

target=${OUTPUTDIR}
source=${TARGETDIR}

while getopts "h?vdrs" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose="-vvv"
        ;;
    d)  delete="--delete"
        ;;
    r)  reverse="--reverse"
	tmp=${source}
	source=${target}
	target=${tmp}
	;;
    s)  dryrun="--dry-run"
	;;
    esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

params="--ignore-time --no-symlinks --parallel=10 ${verbose} ${delete} ${reverse} ${dryrun}"
run "mirror ${params} --exclude=data ${source} ${target}"

if [ -z ${reverse} ]; then
    source=/public_html/phoo
    target=${BASEDIR}/content/phoo
else
    target=/public_html/phoo
    source=${BASEDIR}/content/phoo
fi    

run "mirror ${params} ${source} ${target}"
