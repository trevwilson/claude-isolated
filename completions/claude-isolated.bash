# Bash completion for claude-isolated
# Auto-loaded by bash-completion when claude-isolated is tab-completed

_claude_isolated() {
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Complete branch names after -b
    if [[ "$prev" == "-b" ]]; then
        # Get local branches, strip leading spaces and * marker
        local branches
        branches=$(git branch --format='%(refname:short)' 2>/dev/null)
        COMPREPLY=($(compgen -W "$branches" -- "$cur"))
        return
    fi

    # After -n, no completion (user types custom name)
    if [[ "$prev" == "-n" ]]; then
        return
    fi

    # If current word starts with -, complete flags
    if [[ "$cur" == -* ]]; then
        COMPREPLY=($(compgen -W "-b -n" -- "$cur"))
        return
    fi

    # Otherwise, could offer flags or defer to claude completion
    # For now, suggest flags if none given yet
    local has_b=false has_n=false
    for word in "${COMP_WORDS[@]}"; do
        [[ "$word" == "-b" ]] && has_b=true
        [[ "$word" == "-n" ]] && has_n=true
    done

    local suggestions=""
    $has_b || suggestions="$suggestions -b"
    $has_n || suggestions="$suggestions -n"

    COMPREPLY=($(compgen -W "$suggestions" -- "$cur"))
}

complete -F _claude_isolated claude-isolated
