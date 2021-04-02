{
  inputs.nix.url = "github:NixOS/nix";

  outputs = { self, nix }: {
    checks.x86_64-linux.nix = nix.packages.x86_64-linux.nix.overrideAttrs (old: {
      checkPhase = ''
        runHook preCheck
        set +e
        for i in $(seq 100); do
          echo === Running check, round $i
          make check
        done
        echo === Final check
        set -e
        make check
        runHook postCheck
      '';

      installCheckPhase = ''
        runHook preInstallCheck
        set +e
        for i in $(seq 100); do
          echo Running installcheck, round $i
          make installcheck
        done
        set -e
        echo === Final installcheck
        make installcheck
        runHook postInstallCheck
      '';
    });
  };
}
