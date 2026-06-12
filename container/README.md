# apple container 生活

apple container の上で基本的には生活することとする。

目的としては、ローカルのファイルを必要以上に opencode などに見せたくないということ。
細かい開発用のツールも含め。

## container machine or container

container machine を選んだ方が、

1. init / システムサービスが動く
2. ホストのアイデンティティ自動統合

といったメリットが得られる。

デメリットとしては以下。

* home directory がまるごとマウントかマウントなし、の二択。オール・オア・ナッシング
* カスタムイメージをビルドしないと ubuntu が使えない

    create.sh

で、コンテナが作成される。


    setup.sh

でコンテナがセットアップされる。


