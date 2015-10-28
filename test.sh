#!/bin/bash

ALL="almost-sorted"
FAILURES=
SUCCESSES=

function runtest()
{
  challenge=$1
  shift

  echo "${challenge}:"
  echo
  failures=0
  dir=`basename $PWD`
  if [ "$dir" != "$challenge" ] ; then
    cd $challenge
  fi

  cd tests
  tests=`ls *.in`
  cd ..

  for t in $tests ; do
    name=${t::-3}
    printf "%12s ................. " $name
    $1 < tests/${name}.in > tests/${name}.run
    if cmp -s tests/${name}.run tests/${name}.out ; then
      echo "[ PASSED ]"
    else
      echo "[ FAILED ]"
      failures=$((failures + 1))
    fi
  done

  cd ..
  if [ "$failures" -eq "0" ] ; then
    SUCCESSES="$challenge $SUCCESSES"
  else
    FAILURES="${challenge}($failures) $FAILURES"
  fi
  echo
}

challenges=$*
if [ -z "$challenges" ] ; then
  dir=`basename $PWD`
  if [[ $ALL == *"$dir"* ]] ; then
    challenges=$dir
  else
    echo "Performing all tests..."
    echo
    challenges=$ALL
  fi
fi

for arg in $challenges ; do
  case $arg in
    almost-sorted)
      runtest "almost-sorted" "./almost-sorted.rb"
      ;;
    *)
      echo "Unknown challenge $arg"
      ;;
  esac
done

echo "Tests succeeded: $SUCCESSES"
echo "Tests failed: $FAILURES"

if [ ! -z "$FAILURES" ] ; then
  exit 1
fi

