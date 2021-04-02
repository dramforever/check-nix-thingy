{
  inputs.nix.url = "github:NixOS/nix";

  outputs = { self, nix }: {
    checks.x86_64-linux.nix = nix.packages.x86_64-linux.nix.overrideAttrs (old: {
      checkPhase = ''
        runHook preCheck
        for i in $(seq 100); do
          echo Running check, round $i
          make check
        done
        runHook postCheck
      '';

      installCheckPhase = ''
        runHook preInstallCheck
        for i in $(seq 100); do
          echo Running installcheck, round $i
          make installcheck
        done
        runHook postInstallCheck
      '';
    });
  };
}
