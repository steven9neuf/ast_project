#!/bin/bash

set -e # Set bash flag to interrupt if any command fails

compileCoffee() {
  echo "Compiling coffee files"
  node_modules/.bin/coffee --compile --output lib src
}

compilePug() {
  echo "Compile pug files"
  node_modules/.bin/pug views --out public/html --pretty
}

compileStylus() {
  echo "Compiling stylus files"
  echo "nothing to do"
  node_modules/.bin/stylus styles/*.styl --out public/css
}

main() {
  case "$1" in
  coffee)
  compileCoffee
  ;;

  pug)
  compilePug
  ;;

  stylus)
  compileStylus
  ;;

  *)
  #if [[ ! -z "$1" ]]; then
    echo "Compiling everything"
    compileCoffee
    compilePug
    compileStylus
  #fi;
  ;;
  esac

  echo "Done"
}

main #$1
