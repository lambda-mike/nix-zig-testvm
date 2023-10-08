{ stdenv
, zig 
}:

stdenv.mkDerivation {
  name = "getni";
  src = ./.;

  unpackPhase = ''
    cp -r $src/. .
  '';

  buildPhase = ''
    echo "buildPhase..."
    # you could use GCC to compile C code
    # gcc -o getnic getnic.c
    # you can compile pure C program with the zig compiler instead:
    zig build-exe -lc getnic.c
    zig build-exe -lc getni.zig
    echo "buildPhase done"
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/src
    cp ./getni.zig $out/src/
    cp ./getni $out/bin/
    cp ./getnic.c $out/src/
    cp ./getnic $out/bin/
  '';

  # zig hook is needed to make zig compiler work properly
  nativeBuildInputs = [
    zig.hook
  ];
}
