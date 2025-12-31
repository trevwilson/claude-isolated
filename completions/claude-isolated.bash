# Bash completion for claude-isolated
# Auto-loaded by bash-completion when claude-isolated is tab-completed

_claude_isolated() {
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Complete branch names after -b or -B
    if [[ "$prev" == "-b" || "$prev" == "-B" ]]; then
        # Get local branches (useful for both - -B can use existing branches too)
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
        COMPREPLY=($(compgen -W "-b -B -n" -- "$cur"))
        return
    fi

    # Otherwise, suggest flags that haven't been used yet
    # -b and -B are mutually exclusive
    local has_branch=false has_n=false
    for word in "${COMP_WORDS[@]}"; do
        [[ "$word" == "-b" || "$word" == "-B" ]] && has_branch=true
        [[ "$word" == "-n" ]] && has_n=true
    done

    local suggestions=""
    $has_branch || suggestions="$suggestions -b -B"
    $has_n || suggestions="$suggestions -n"

    COMPREPLY=($(compgen -W "$suggestions" -- "$cur"))
}

complete -F _claude_isolated claude-isolated
