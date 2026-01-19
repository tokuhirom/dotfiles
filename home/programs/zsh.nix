{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    # XDG 準拠のディレクトリを使用
    dotDir = "${config.xdg.configHome}/zsh";

    # 補完機能を有効化
    enableCompletion = true;

    # 自動補完サジェスチョンを有効化
    autosuggestion.enable = true;

    # シンタックスハイライトを有効化
    syntaxHighlighting.enable = true;

    # コマンド履歴設定
    history = {
      size = 100000;
      save = 100000;
      extended = true;  # タイムスタンプを保存
      share = true;     # セッション間で履歴を共有
    };

    # 追加設定
    initContent = ''
      # direnv の activation
      if command -v direnv &> /dev/null; then
        eval "$(direnv hook zsh)"
      fi

      # mise の activation
      if command -v mise &> /dev/null; then
        eval "$(mise activate zsh)"
      fi

      # 既存の .zshrc を読み込み
      if [ -f ~/dotfiles/config/.zshrc ]; then
        source ~/dotfiles/config/.zshrc
      fi
    '';
  };
}
