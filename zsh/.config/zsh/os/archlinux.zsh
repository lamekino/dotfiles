# https://fosskers.github.io/aura/usage.html
# https://github.com/fosskers/aura
if command -v aura &>/dev/null; then
    alias pacman="aura --hotedit --unsuppress"
    alias aura="aura --hotedit --unsuppress"
    export HAS_AURA=1
fi

alias hd="hexdump -C"
