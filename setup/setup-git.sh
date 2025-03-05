#!/bin/bash
# set -x
# set -e

if [[ -d /Users/ ]] ; then
    if [[ ! -e /usr/local/bin/git-lfs ]] ; then
        brew install git-lfs
    fi
fi

git lfs install

git config --global user.email "tokuhirom@gmail.com"
git config --global user.name "Tokuhiro Matsuno"

# 色をつける
git config --global color.ui true

# merge 済ブランチの削除
# http://qiita.com/items/10a57a4f1d2806e3a3b8
git config --global alias.br-cleanup '!git branch --merged | egrep -v "main|master|develop" | grep -v \* | xargs -I % git branch -d %'

# ブランチ一覧を時刻順で
# http://d.hatena.ne.jp/kazuhooku/20130205/1360039870
# git config --global alias.branch-list "!(for i in `git branch | colrm 1 2` ; do echo `git log --date=iso8601 -n 1 --pretty="format:[%ai] %h" $i` $i ; done) | sort -r"

# git merge するときは常に --no-ff(1.7.6以降)
git config --global merge.ff false

# setup rebase for every tracking branch
git config --global branch.autosetuprebase always

# exclude files
git config --global core.excludesfile ~/.gitignore_global

git config --global alias.ci 'commit'

git config --global alias.co 'checkout'
git config --global alias.st 'status --short --branch'
git config --global alias.br 'branch'
git config --global alias.tree 'log --graph --pretty=oneline --abbrev-commit'

# http://stackoverflow.com/questions/6764953/what-is-the-reason-for-the-a-b-prefixes-of-git-diff
git config --global diff.noprefix true

git config --global alias.fetch-pulls 'fetch origin +refs/pull/*:refs/remotes/pull/*'

# I'm vimmer
git config --global core.editor vim

git config --global init.defaultBranch main

git config --global submodule.recurse true

# https://github.blog/2022-06-29-improve-git-monorepo-performance-with-a-file-system-monitor/
git config --global core.fsmonitor true
git config --global core.untrackedcache true


# https://blog.gitbutler.com/how-git-core-devs-configure-git/
git config --global column.ui auto
git config --global branch.sort -committerdate

# タグのソート順をスマートにする
git config --global tag.sort version:refname


# よりよい diff
git config --global diff.algorithm histogram
git config --global diff.colorMoved plain
git config --global diff.mnemonicPrefix true
git config --global diff.renames true

git config --global push.default simple # (default since 2.0)
git config --global push.autoSetupRemote true
git config --global push.followTags true

git config --global fetch.prune true
git config --global fetch.pruneTags true
git config --global fetch.all true

git config --global help.autocorrect prompt

git config --global commit.verbose true

git config --global rerere.enabled true
git config --global rerere.autoupdate true

git config --global rebase.autoSquash true
git config --global rebase.autoStash true
git config --global rebase.updateRefs true

git config --global merge.conflictstyle zdiff3

git config --global pull.rebase true

