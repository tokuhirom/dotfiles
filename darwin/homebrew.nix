{ ... }: {
  # Homebrew は Brewfile で管理（bin/brew-sync）
  # ADR-0015: macOS では Homebrew を優先
  #
  # nix-darwin の homebrew モジュールは無効化し、
  # Brewfile + brew bundle で宣言的に管理する

  homebrew = {
    enable = false;
  };
}
