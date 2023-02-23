#!/bin/sh
BASE_URL="https://gitignore.io/api/"
LIST_SLUG="list/"

CACHE_DIR="$HOME/.cache/git-ignore"


# ==== HELPER FUNCTIONS ========================================================
_git_ignore_get_type_list() {
    # Use the cache file if we can
    LIST=`cat "$CACHE_DIR/templates" 2>/dev/null`

    if [ "$LIST" = "" ]; then
        if type "wget" > /dev/null; then
            LIST="`wget -qO- $BASE_URL$LIST_SLUG`"
        elif type "curl" > /dev/null; then
            LIST="`curl -s $BASE_URL$LIST_SLUG`"
        fi

        LIST=$(printf '%s' "$LIST" | tr '\n' ' ' | tr ',' ' ')
        mkdir -p "$CACHE_DIR"
        echo "$LIST" > "$CACHE_DIR/templates"
    fi

    echo "$LIST"
}


_git_ignore_filter_type_list() {
    _input="$1"
    _list="$2"

    if [ "$_input" = "" ]; then
        _results="$_list"
    else
        _results=""
        for i in $_list; do
            case $i in
                "$_input"*) _results="$_results $i"
            esac
        done
    fi

    echo "$_results"
}
# ==============================================================================



# ==== AUTOCOMPLETE ============================================================
_git_ignore() {
    #echo "${COMP_WORDS[-1]}"
    _input="${COMP_WORDS[$COMP_CWORD]}"

    _list="`_git_ignore_get_type_list`"
    _matches=`_git_ignore_filter_type_list "$_input" "$_list"`
    COMPREPLY=( $(compgen -W "$_matches") )
}

_git-ignore() {
    _git_ignore
}

complete -F _git-ignore git-ignore
# ==============================================================================
