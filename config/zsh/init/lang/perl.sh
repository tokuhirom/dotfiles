# -------------------------------------------------------------------------
# Perl5
# -------------------------------------------------------------------------

export PERL_BADLANG=0
export PERL_CPANM_OPT="--no-man-pages --no-prompt --no-interactive"
export PERL_AUTOINSTALL="--defaultdeps"

export PATH="$HOME/.plenv/bin:$HOME/.plenv/shims:$PATH"
if which plenv &> /dev/null; then eval "$(plenv init -)"; fi
