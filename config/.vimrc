" *************************************************************************
" tokuhirom's .vimrc file.
"
" vim-plug 本体は dotfiles に vendoring 済み (config/.vim/autoload/plug.vim)。
" link.sh で ~/.vim/autoload/plug.vim に symlink される。
" 更新手順は config/.vim/README.md を参照 (ADR-0017)。
"
" :e ++enc=cp932
" :e ++enc=euc-jp
"
" *************************************************************************

" -------------------------------------------------------------------------
" :PlugInstall  Install plugins
" :PlugUpdate   Update plugins
" -------------------------------------------------------------------------

" -------------------------------------------------------------------------
" Basic settings.
"
" -------------------------------------------------------------------------

    nnoremap j gj
    nnoremap k gk
    nnoremap <c-a> <Nop>
    nnoremap <c-x> <Nop>

    set expandtab
    set shiftround
    set autoindent
    set backspace=indent,eol,start
    set hidden
    set history=50
    set hlsearch
    set ignorecase
    set incsearch
    set laststatus=2
    set nobackup
    set ruler
    set shiftwidth=4
    set showcmd
    set showmatch
    set smartcase
    set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
    set tabstop=4
    set wrapscan
    syntax on
    " Auto save.
    " autocmd CursorHold * update
    set updatetime=500
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,utf-16,euc-jp,iso-2022-jp,cp932
    set ambw=double
    set modeline
    set modelines=5

    " set spellfile=~/.spell-dict

    " .swp files output to:
    set directory=~/.vim/tmp

    " Highlight white space in EOL
    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/
    autocmd WinEnter * match WhitespaceEOL /\s\+$/

    " set list
    " set listchars=tab:»--,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" -------------------------------------------------------------------------
" vim plugins
"
" supply chain risk 低減のため、全プラグインを commit hash で固定している。
" 更新する場合は upstream の変更内容を確認した上でハッシュを書き換えて
" :PlugUpdate を実行すること。
" -------------------------------------------------------------------------

    filetype off                  " required

    call plug#begin('~/.vim/plugged')

    " ctrlp
    Plug 'ctrlpvim/ctrlp.vim', { 'commit': '86872f021c4e245e3c583054fda82fb820a2faee' }

    " color scheme
    " Plug 'w0ng/vim-hybrid'
    Plug 'morhetz/gruvbox', { 'commit': '697c00291db857ca0af00ec154e5bd514a79191f' }

    Plug 'rhysd/clever-f.vim', { 'commit': '6a3ac5e3688598af9411ab741737f98c47370c22' }

    Plug 'osyo-manga/vim-anzu', { 'commit': '45566dffd29612a763239abadd3ab2cd78bd5638' }

    " language support
    Plug 'fatih/vim-go', { 'commit': 'fc429c8e2c70c7964065a7e9631cca6da46a8f15' }
    Plug 'tokuhirom/vim-markdown', { 'commit': '40091fc12ce3188978d13c464f84b946b29f6345' }
    Plug 'vim-perl/vim-perl', { 'commit': '25ecb0061a3558d242a471b162aad20e4308815d' }
    Plug 'moznion/vim-cpanfile', { 'commit': 'd69eb9aee5c60da6ff68b8fc3058b69bf5a4f6d9' }

    " quickfix の該当箇所にカーソルを移動させるとエラー内容がコマンドウィンドウに出力される
    Plug 'dannyob/quickfixstatus', { 'commit': 'fd3875b914fc51bbefefa8c4995588c088163053' }

    " Perl thing
    Plug 'y-uuki/perl-local-lib-path.vim', { 'commit': '5cdf5f22f86893ac9559b74eeaf759a3c7d32809' }

    Plug 'fholgado/minibufexpl.vim', { 'commit': 'ad72976ca3df4585d49aa296799f14f3b34cf953' }

    Plug 'editorconfig/editorconfig-vim', { 'commit': '13b86c5c691785ffbf2d6508c621dabb08e93df0' }

    call plug#end()
    filetype plugin indent on

" ------------------------------------------------------------------------- 
" color
" ------------------------------------------------------------------------- 

    " Enable 256 colors mode.
    set t_Co=256
    set background=dark

    " colorscheme hybrid
    colorscheme gruvbox

"---------------------------------------------------------------------------
" vim-anzu
" display "n/m" in search result
"---------------------------------------------------------------------------

    " mapping
    nmap n <Plug>(anzu-n-with-echo)
    nmap N <Plug>(anzu-N-with-echo)
    nmap * <Plug>(anzu-star-with-echo)
    nmap # <Plug>(anzu-sharp-with-echo)

    " clear status
    nmap <Esc><Esc> <Plug>(anzu-clear-search-status)


    " statusline
    set statusline=%{anzu#search_status()}

" -------------------------------------------------------------------------
" matchit(jump between html open tag and html close tag)
"    ref. http://nanasi.jp/articles/vim/matchit_vim.html
" -------------------------------------------------------------------------
    source $VIMRUNTIME/macros/matchit.vim

" ------------------------------------------------------------------------- 
" actionscript
" ------------------------------------------------------------------------- 
    autocmd BufRead *.as set filetype=javascript

" ------------------------------------------------------------------------- 
" MySQL
" ------------------------------------------------------------------------- 
    autocmd BufRead *.sql set filetype=mysql

" -------------------------------------------------------------------------
"  tags
" -------------------------------------------------------------------------
   set tags+=tags;

" -------------------------------------------------------------------------
" ruby
" -------------------------------------------------------------------------
    autocmd FileType ruby setlocal ts=2 sw=2 sts=0

" ------------------------------------------------------------------------- 
" path
" ------------------------------------------------------------------------- 
   let $PATH="/usr/bin/:/usr/local/bin/:" . $PATH
   set path = "lib,/usr/local/bin/,."

"---------------------------------------------------------------------------
" html
" ------------------------------------------------------------------------- 

    autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType xml setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType tt2html setlocal expandtab shiftwidth=2 tabstop=2
    autocmd FileType markdown setlocal expandtab shiftwidth=4 tabstop=4

"---------------------------------------------------------------------------
" c
" ------------------------------------------------------------------------- 

    autocmd FileType c setlocal expandtab ts=2 sw=2 sts=0
    autocmd FileType cpp setlocal expandtab ts=2 sw=2 sts=0
    autocmd FileType yacc setlocal expandtab ts=2 sw=2 sts=0

    function! s:clang_format()
        let now_line = line(".")
        exec ":%! clang-format"
        exec ":" . now_line
    endfunction

    if executable('clang-format')
        augroup cpp_clang_format
            autocmd!
            autocmd BufWrite,FileWritePre,FileAppendPre *.[ch] call s:clang_format()
        augroup END
    endif

" -------------------------------------------------------------------------
" ChangeLog
"
" -------------------------------------------------------------------------

    let g:changelog_username = 'tokuhirom <tokuhirom@gmail.com>'
    let g:changelog_timeformat = "%Y-%m-%d(%a)"
    " map ,d <Esc>:exec 'edit ~/Dropbox/ChangeLogs/' . hostname() . '/ChangeLog'<CR>

" -------------------------------------------------------------------------
" OSX crontab hack.
" http://blog.kcrt.net/2010/06/18/004658
" -------------------------------------------------------------------------
    autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

" -------------------------------------------------------------------------
" ctrlp
"
" -------------------------------------------------------------------------
"
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlPMixed'

    if executable('ag')
        let g:ctrlp_use_caching = 0
        let g:ctrlp_user_command = 'ag -l -i --nocolor --nogroup --hidden --ignore .git -g "" %s'        " MacOSX/Linux
    endif
    " let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
    let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']

    let g:ctrlp_max_depth = 10
    let g:ctrlp_clear_cache_on_exit = 1

    set wildignore+=*/build/**
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class

    " let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn|cpanm|cache|plenv)|blib)$'
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn|gradle)|target|blib)$',
    \ 'file': '\.(exe|so|dll|class)$',
    \ }


    " Guess vcs root dir
    let g:ctrlp_working_path_mode = 'ra'
    " Open new file in current window
    let g:ctrlp_open_new_file = 'r'

    " let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

    nnoremap bg :<C-u>CtrlPMixed<CR>
    nnoremap bt :<C-u>CtrlPTag<CR>
    nnoremap be :CtrlPMRU<CR>

" -------------------------------------------------------------------------
" golang
"
" -------------------------------------------------------------------------

    let g:go_version_warning = 0

    " gocode
    if $GOROOT != ''
        "golint
        " go get -u github.com/golang/lint/golint
        exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
        " gocode
        " go get github.com/nsf/gocode
        exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
    endif

    "  mkdir -p $GOPATH/bin
    "  go get github.com/nsf/gocode
    "  $GOPATH/src/github.com/nsf/gocode/vim/update.sh

    let g:gofmt_command = 'goimports'

    autocmd BufNewFile *.go 0r $HOME/.templates/go.txt

    au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
    au FileType go compiler go

    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    autocmd FileType go nnoremap gi :GoImports<cr><esc>:w<cr>

" -------------------------------------------------------------------------
" groovy
"
" -------------------------------------------------------------------------

    autocmd FileType groovy setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    augroup filetypedetect
    autocmd! BufNewFile,BufRead *.gradle setf groovy
    augroup END

    autocmd BufNewFile build.gradle  0r $HOME/.templates/build.gradle

" -------------------------------------------------------------------------
" perl
"
" -------------------------------------------------------------------------

    iabbrev ,# # =========================================================================
    iabbrev .# # -------------------------------------------------------------------------

    " autocmd FileType perl setlocal spell spelllang=en_us

    let perl_include_pod = 1

    au BufNewFile,BufRead cpanfile set filetype=cpanfile
    au BufNewFile,BufRead cpanfile set syntax=perl.cpanfile
    autocmd FileType perl PerlLocalLibPath

    " folding
    " zM: close all
    " zo: open
    " zm: close
    " zc: close
    " zR: open all
    " let perl_fold = 1
    " let perl_nofold_packages=1
    " set fdm=syntax

    set iskeyword+=:  " make tags with :: in them useful

    augroup filetypedetect
        autocmd! BufNewFile,BufRead *.psgi setf perl
        autocmd! BufNewFile,BufRead cpanfile setf perl
        autocmd! BufNewFile,BufRead *.tt setf tt2html
        autocmd! BufNewFile,BufRead *.tj setf tj
        autocmd! BufNewFile,BufRead *.ejs setf html
        autocmd! BufNewFile,BufRead *.html.ftl setf html.ftl
        autocmd! BufNewFile,BufRead *.xml setf xml
    augroup END

    au BufRead,BufNewFile Makefile* setlocal noexpandtab

    autocmd BufNewFile *.pl 0r $HOME/.templates/perl-script.txt
    autocmd BufNewFile *.t  0r $HOME/.templates/perl-test.txt

    function! s:pm_template()
        let path = substitute(expand('%'), '.*lib/', '', 'g')
        let path = substitute(path, '[\\/]', '::', 'g')
        let path = substitute(path, '\.pm$', '', 'g')

        call append(0, 'package ' . path . ';')
        call append(1, 'use strict;')
        call append(2, 'use warnings;')
        call append(3, 'use utf8;')
        call append(4, 'use 5.010_001;')
        call append(5, '')
        call append(6, '')
        call append(7, '')
        call append(8, '1;')
        call cursor(6, 0)
        " echomsg path
    endfunction
    autocmd BufNewFile *.pm call s:pm_template()

" -------------------------------------------------------------------------
" perltidy
" -------------------------------------------------------------------------
    map ,pt <Esc>:%! perltidy -se<CR>
    map ,ptv <Esc>:'<,'>! perltidy -se<CR>

" -------------------------------------------------------------------------
" package name validation for perl
" -------------------------------------------------------------------------

    scriptencoding utf-8

    function! s:get_package_name()
        let mx = '^\s*package\s\+\([^ ;]\+\)'
        for line in getline(1, 5)
        if line =~ mx
        return substitute(matchstr(line, mx), mx, '\1', '')
        endif
        endfor
        return ""
    endfunction

    function! s:check_package_name()
        let path = substitute(expand('%:p'), '\\', '/', 'g')
        let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
        if path[-len(name):] != name
            echohl WarningMsg
            echomsg "File name and package name is not matched"
            echohl None
        endif
    endfunction

    au! BufWritePost *.pm call s:check_package_name()

" -------------------------------------------------------------------------
" tabs
" -------------------------------------------------------------------------
    nnoremap <silent> gd :<C-u>bdelete<CR>
    nnoremap <silent> gn :<C-u>bnext<CR>
    nnoremap <silent> gp :<C-u>bprevious<CR>

