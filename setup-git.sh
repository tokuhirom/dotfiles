# set -x
# set -e

git config --global user.email "tokuhirom@gmail.com"
git config --global user.name "Tokuhiro Matsuno"

# 色をつける
git config --global color.ui true

# merge 済ブランチの削除
# http://qiita.com/items/10a57a4f1d2806e3a3b8
git config --global alias.delete-merged-branches '!git branch --merged | grep -v \* | xargs -I % git branch -d %'

# ブランチ一覧を時刻順で
# http://d.hatena.ne.jp/kazuhooku/20130205/1360039870
# git config --global alias.branch-list "!(for i in `git branch | colrm 1 2` ; do echo `git log --date=iso8601 -n 1 --pretty="format:[%ai] %h" $i` $i ; done) | sort -r"

# git merge するときは常に --no-ff(1.7.6以降)
git config --global merge.ff false

# setup rebase for every tracking branch
git config --global branch.autosetuprebase always

# git pull するときは常に rebase(1.7.9以降)
# git config --global pull.rebase true

# ref. http://stackoverflow.com/questions/15915430/what-exactly-does-gits-rebase-preserve-merges-do-and-why
# 1.8.5 or later
git config --global pull.rebase preserve

# exclude files
git config --global core.excludesfile ~/.gitignore_global

# git commit -v by default
git config --global alias.ci 'commit --verbose'

git config --global alias.co 'checkout'
git config --global alias.st 'status --short --branch'
git config --global alias.br 'branch'
git config --global alias.tree 'log --graph --pretty=oneline --abbrev-commit'

git config --global push.default simple

# http://stackoverflow.com/questions/6764953/what-is-the-reason-for-the-a-b-prefixes-of-git-diff
git config --global diff.noprefix true

git config --global alias.fetch-pulls 'fetch origin +refs/pull/*:refs/remotes/pull/*'

# I'm vimmer
git config --global core.editor vim

