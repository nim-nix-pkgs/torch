{
  description = ''A nim flavor of pytorch'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-torch-v0_1_10.flake = false;
  inputs.src-torch-v0_1_10.owner = "fragcolor-xyz";
  inputs.src-torch-v0_1_10.ref   = "refs/tags/v0.1.10";
  inputs.src-torch-v0_1_10.repo  = "nimtorch";
  inputs.src-torch-v0_1_10.type  = "github";
  
  inputs."fragments".dir   = "nimpkgs/f/fragments";
  inputs."fragments".owner = "riinr";
  inputs."fragments".ref   = "flake-pinning";
  inputs."fragments".repo  = "flake-nimble";
  inputs."fragments".type  = "github";
  inputs."fragments".inputs.nixpkgs.follows = "nixpkgs";
  inputs."fragments".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-torch-v0_1_10"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-torch-v0_1_10";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}