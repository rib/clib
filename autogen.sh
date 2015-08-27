#!/bin/sh
# Run this to generate all the initial makefiles, etc.

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

cd $srcdir
PROJECT=clib

test -f clib/clib.h || {
	echo "You must run this script in the top-level $PROJECT directory"
	exit 1
}

AUTOMAKE_VERSIONS="1.15 1.14"
for version in $AUTOMAKE_VERSIONS; do
	if automake-$version --version < /dev/null > /dev/null 2>&1 ; then
		AUTOMAKE=automake-$version
		ACLOCAL=aclocal-$version
		export AUTOMAKE ACLOCAL
		break
	fi
done

if test -z "$AUTOMAKE"; then
	echo
	echo "You must have one of automake $AUTOMAKE_VERSIONS to compile $PROJECT."
	echo "Install the appropriate package for your distribution,"
	exit 1
fi

rm -rf autom4te.cache

autoreconf -vfi || exit $?

./configure "$@" || exit $?

echo "Now type 'make' to compile $PROJECT."
