" mkdir -p ~/.vim/bundle/ ~/.vim/tmp/
" git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

" -------------------------------------------------------------------------
" Basic settings.
"
" -------------------------------------------------------------------------
    set nocompatible " must be first!

    nnoremap j gj
    nnoremap k gk

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
    set updatetime=500
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,utf-16,euc-jp,iso-2022-jp,utf-8,cp932,utf-16
    set ambw=double
    set modeline
    set modelines=5

    set guifont=Andale\ Mono:h14
    set guifontwide=ヒラギノ角ゴ\ StdN\ W8:h14

    " .swp files output to:
    set directory=~/.vim/tmp

    " Highlight white space at EOL
    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/
    autocmd WinEnter * match WhitespaceEOL /\s\+$/

    " OSX crontab hack.
    " http://blog.kcrt.net/2010/06/18/004658
    autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup


    " Machine specific settings
    if filereadable("/Users/tokuhirom/.vimrc.local")
        source /Users/tokuhirom/.vimrc.local
    endif
