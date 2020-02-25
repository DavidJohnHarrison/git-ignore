#!/bin/sh
BASE_URL="https://gitignore.io/api/"
LIST_SLUG="list/"

CACHE_DIR="$HOME/.cache/git-ignore"


# ==== HELPER FUNCTIONS ========================================================
get_type_list() {
    if type "wget" > /dev/null; then
        LIST="`wget -qO- $BASE_URL$LIST_SLUG`"
    elif type "curl" > /dev/null; then
        LIST="`curl -s $BASE_URL$LIST_SLUG`"
    fi

    LIST=$(printf '%s' "$LIST" | tr '\n' ' ' | tr ',' ' ')
    mkdir -p "$CACHE_DIR"
    echo "$LIST" > "$CACHE_DIR/templates"
    echo "$LIST"
}


check_if_valid_type() {
    for _type in $2; do
        if [ "$1" = "$_type" ]; then
            return 0
        fi
    done
    return 1
}


get_url_from_types() {
    echo "$@"
    _type_list=$(printf '%s,' "$@")

    # Cut off the trailing ','
    _type_list=${_type_list%?}

    echo "$BASE_URL$_type_list"
}


get_gitignore_file_from_url() {
    echo "$1"
    if type "wget" > /dev/null; then
        _gitignore_file="`wget -qO- $1`"
    elif type "curl" > /dev/null; then
        _gitignore_file="`curl -s $1`"
    fi
    echo "$_gitignore_file"
}
# ==============================================================================



# ==== NO ARGUMENTS GIVEN ======================================================
if [ "$1" = "" ]; then
    echo "No template(s) specified, no changes made."
# ==============================================================================



# ==== LIST ARGUMENT GIVEN =====================================================
elif [ "$1" = "--list" -o "$1" = "-l" ]; then
    LIST="`get_type_list`"
    for i in $LIST; do
       echo -n "$i, "
    done
# ==============================================================================



# ==== TYPE ARGUMENT(S) GIVEN ==================================================
else
    LIST="`get_type_list`"

    # ---- Input Sanitization --------------------------------------------------
    _input_types=$(printf '%s ' "$@" | tr '\n' ' ' | tr ',' ' ')
    _is_success=0
    for t in $_input_types; do
        check_if_valid_type "$t" "$LIST"
        if [ $? -ne 0 ]; then
            # Invalid type
            _is_success=1
            echo "ERROR: Unrecognised type '$t'"
        fi
    done

    if [ $_is_success -ne 0 ]; then
        exit
    fi

    _gitignore_url="`get_url_from_types $_input_types`"
    _gitignore_file="`get_gitignore_file_from_url "$_gitignore_url"`"
    echo "$_gitignore_file" >> ".gitignore"
    # --------------------------------------------------------------------------
fi
# ==============================================================================
