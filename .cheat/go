# shared library

17:18 tokuhirom go に shared library が入るから型安全ではなくなる! 人類の終わりだ! ってモリスが昨日騒いでたんだけど
17:18 tokuhirom go に shared library 入る云々の話しがまったく見当たらない
17:19 mattn x64 だけ -build-mode=c-shared ってので共有ライブラリが作れる様になってるんです
17:19 mattn 元は android 用だけど
17:20 tokuhirom あー
17:20 mattn http://qiita.com/yanolab/items/1e0dd7fd27f19f697285
17:20 mattn shared の方は go world になる予定
17:20 mattn いつになるかわからないけど
17:21 tokuhirom ふむ
17:21 tokuhirom この感じで実装すれば、go で ruby なり perl なりで利用可能なライブラリ作れるってことか
17:22 mattn ですね
17:22 mattn 元々 gccgo では shared lib は作れたので一部の人は既にやってた
17:22 tokuhirom nrhd
17:23 tokuhirom これを go からロードすれば、プラグイン機構とかも作れる、のかな
17:23 mattn ですね
17:24 mattn ただ x64 以外の進捗がまるっきしない
17:24 tokuhirom あら
17:24 mattn osx も誰も動いてない
