{ pkgs, ... }:
{
  # Homebrew で入手できないパッケージのみ Nix で管理
  # ADR-0015: macOS では Homebrew を優先
  #
  # 現在、すべてのパッケージは Homebrew で管理されています

  environment.systemPackages = with pkgs; [
    # Homebrew にないパッケージがあればここに追加
  ];
}
