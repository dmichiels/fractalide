# Build an idris package
#
# args: Additional arguments to pass to mkDerivation. Generally should include at least
#       name and src.
{ stdenv, idris, gmp }: args: stdenv.mkDerivation ({
  preHook = ''
    # Library import path
    export IDRIS_LIBRARY_PATH=$PWD/idris-libs
    mkdir -p $IDRIS_LIBRARY_PATH
    
    # Library install path
    export IBCSUBDIR=$out/lib/${idris.name}
    mkdir -p $IBCSUBDIR

    addIdrisLibs () {
      if [ -d $1/lib/${idris.name} ]; then
        ln -sf $1/lib/${idris.name}/* $IDRIS_LIBRARY_PATH
      fi
    }

    envHooks+=(addIdrisLibs)
  '';

  buildPhase = ''
    ${
      if (stdenv.lib.attrByPath ["unifiedIdrisEdges"] [] args) != [] then
        "ln -s ${args.unifiedIdrisEdges}/edges.idr Edges.idr"
      else ""
    }
    ${idris}/bin/idris --build *.ipkg
  '';

  doCheck = true;

  checkPhase = ''
    if grep -q test *.ipkg; then
      ${idris}/bin/idris --testpkg *.ipkg
    fi
  '';

  installPhase = ''
    if [ -a fvm ]; then
      cp fvm $out/
    else
      ${idris}/bin/idris --install *.ipkg --ibcsubdir $IBCSUBDIR
      cp --parents -r *.idr $IBCSUBDIR/*/
    fi
  '';

  buildInputs = [ gmp ];
} // args)
