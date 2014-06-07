# Provide cabal exec command for sandbox-aware execution
cabal() {
  if [[ $1 == "exec" ]]
  then
    shift
    local dir=$PWD conf db
    while :; do
        conf=$dir/cabal.sandbox.config
        [[ ! -f $conf ]] || break
        if [[ -z $dir ]]; then
            echo "Cannot find cabal.sandbox.config" >&2
            return 1
        fi
        dir=${dir%/*}
    done

    db=$(sed -ne '/^package-db: */{s///p;q}' "$conf")
    if [[ ! -d $db ]]; then
        echo "$db: does not exist"
        return 1
    fi

    pkg_path=$(command cabal sandbox hc-pkg list 2> /dev/null | grep \: | tac | sed 's/://' | paste -d: - -)
    if [[ $# == 0 ]]; then
        echo GHC_PACKAGE_PATH=${pkg_path}:
    else
        GHC_PACKAGE_PATH=${pkg_path} PATH=$(dirname $db)/bin:$PATH "$@"
    fi
  else
    command cabal $@
  fi
}

# Wrappers for original commands
ghci() {
   if [[ -e "cabal.sandbox.config" ]]; then
      command cabal exec ghci $@
   else
      command ghci $@
   fi
}
ghc() {
   if [[ -e "cabal.sandbox.config" ]]; then
      command cabal exec ghc $@
   else
      command ghc $@
   fi
}
