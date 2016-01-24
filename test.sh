#!/bin/bash

ALL="almost-sorted acm-icpc-team morgan-and-a-string code-cpp-3-attribute-parser"
FAILURES=
SUCCESSES=

function compile()
{
  challenge=$1
  shift

  echo "Building ${challenge}"
  dir=`basename $PWD`
  if [ "$dir" != "$challenge" ] ; then
    cd $challenge
  fi

  make
  cd ..
}

function runtest()
{
  challenge=$1
  shift

  echo "${challenge}:"
  echo
  failures=
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
      failures="#$name,$failures"
    fi
  done

  cd ..
  if [ -z "$failures" ] ; then
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
    acm-icpc-team)
      compile "acm-icpc-team"
      runtest "acm-icpc-team" "./acm-icpc-team"
      ;;
    morgan-and-a-string)
      runtest "morgan-and-a-string" "./morgan-and-a-string.rb"
      ;;
    code-cpp-3-attribute-parser)
      compile "code-cpp-3-attribute-parser"
      runtest "code-cpp-3-attribute-parser" "./attribute-parser"
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

