{ pkgs, ... }:

{
  home.packages = [
    (pkgs.llama-cpp.override { cudaSupport = true; })
  ];
}
