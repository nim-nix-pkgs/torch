{
  description = ''A nim flavor of pytorch'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimtorch-v0_1_22.flake = false;
  inputs.src-nimtorch-v0_1_22.ref   = "refs/tags/v0.1.22";
  inputs.src-nimtorch-v0_1_22.owner = "fragcolor-xyz";
  inputs.src-nimtorch-v0_1_22.repo  = "nimtorch";
  inputs.src-nimtorch-v0_1_22.dir   = "";
  inputs.src-nimtorch-v0_1_22.type  = "github";
  
  inputs."fragments".owner = "nim-nix-pkgs";
  inputs."fragments".ref   = "master";
  inputs."fragments".repo  = "fragments";
  inputs."fragments".dir   = "master";
  inputs."fragments".type  = "github";
  inputs."fragments".inputs.nixpkgs.follows = "nixpkgs";
  inputs."fragments".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimtorch-v0_1_22"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimtorch-v0_1_22";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}