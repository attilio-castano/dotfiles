#!/usr/bin/env zsh
# Git-focused FZF helpers with worktree awareness

typeset -g __FZF_GIT_MODULE_PATH=${${(%):-%N}:A}
typeset -gA __FZF_GIT_WORKTREES
typeset -g __FZF_GIT_WORKTREE_CURRENT=""

if [[ -n ${FZF_GIT_BIN-} ]]; then
    typeset -g __FZF_GIT_BIN=$FZF_GIT_BIN
elif (( $+commands[git] )); then
    typeset -g __FZF_GIT_BIN=$commands[git]
else
    typeset -g __FZF_GIT_BIN=$(command -v git 2>/dev/null)
fi

__fzf_git() {
    "${__FZF_GIT_BIN:-git}" "$@"
}

__fzf_git_repo_root() {
    __fzf_git rev-parse --show-toplevel 2>/dev/null
}

__fzf_git_cd_safely() {
    emulate -L zsh
    local dest=$1

    if [[ -z $dest || ! -d $dest ]]; then
        echo "Missing worktree path: $dest" >&2
        return 1
    fi

    local restore_zoxide=0
    local -a saved_chpwd
    if (( ${+functions[__zoxide_hook]} )) && ! command -v zoxide >/dev/null 2>&1; then
        saved_chpwd=(${chpwd_functions[@]})
        chpwd_functions=(${chpwd_functions:#__zoxide_hook})
        restore_zoxide=1
    fi

    builtin cd "$dest" || return 1

    if (( restore_zoxide )); then
        chpwd_functions=(${saved_chpwd[@]})
    fi

    return 0
}

__fzf_git_collect_worktrees() {
    emulate -L zsh
    typeset -A map
    local line path branch
    map=()

    while IFS= read -r line; do
        case $line in
            worktree\ *)
                path=${line#worktree }
                ;;
            branch\ refs/heads/*)
                branch=${line#branch refs/heads/}
                map[$branch]=$path
                ;;
            branch\ *)
                branch=${line#branch }
                map[$branch]=$path
                ;;
        esac
    done < <(__fzf_git worktree list --porcelain 2>/dev/null || true)

    typeset -gA __FZF_GIT_WORKTREES
    __FZF_GIT_WORKTREES=()
    for branch path in ${(kv)map}; do
        __FZF_GIT_WORKTREES[$branch]=$path
    done

    typeset -g __FZF_GIT_WORKTREE_CURRENT
    __FZF_GIT_WORKTREE_CURRENT=""
    local repo_root
    repo_root=$(__fzf_git_repo_root)
    if [[ -n $repo_root ]]; then
        for branch path in ${(kv)__FZF_GIT_WORKTREES}; do
            if [[ $path == $repo_root ]]; then
                __FZF_GIT_WORKTREE_CURRENT=$branch
                break
            fi
        done
    fi
}

__fzf_git_branch_lines() {
    emulate -L zsh
    setopt localoptions
    unsetopt xtrace verbose

    local repo_root
    repo_root=$(__fzf_git_repo_root)

    typeset -A branch_paths
    branch_paths=()
    while IFS=$'	' read -r map_branch map_path; do
        [[ -n $map_branch && -n $map_path ]] && branch_paths[$map_branch]=$map_path
    done < <(__fzf_git worktree list --porcelain 2>/dev/null |
        awk '
            function emit() {
                if (path != "" && branch != "") {
                    printf("%s\t%s\n", branch, path);
                }
                path=""; branch="";
            }
            /^worktree / { emit(); path = substr($0, 10); next }
            /^branch / {
                if ($2 ~ /^refs\/heads\//) branch = substr($2, 12);
                else branch = $2;
                next
            }
            /^$/ { emit(); next }
            END { emit() }
        ')

    local raw
    local -a locals remotes
    locals=()
    remotes=()
    while IFS= read -r raw; do
        [[ -z $raw ]] && continue
        if [[ $raw == remotes/* ]]; then
            remotes+=$raw
        else
            locals+=$raw
        fi
    done < <(__fzf_git branch -a --no-color 2>/dev/null | grep -v HEAD | sed 's/^[*+ ]*//' | sort -u)

    local path display target
    local -a notes
    for raw in "${locals[@]}" "${remotes[@]}"; do
        [[ -z $raw ]] && continue
        target=$raw
        if [[ $raw == remotes/* ]]; then
            target=${raw#remotes/}
            target=${target#*/}
        fi
        path=${branch_paths[$target]}

        if [[ $raw == remotes/* ]]; then
            display=${raw#remotes/}
        else
            display=$target
        fi

        notes=()
        if [[ -n $path ]]; then
            if [[ $path == $repo_root ]]; then
                notes+=(current)
            else
                notes+=("wt:${path:t}")
            fi
        fi
        if [[ $raw == remotes/* ]]; then
            notes+=(remote)
        fi
        if (( ${#notes} )); then
            display+=" — ${(j:, :)notes}"
        fi

        printf '%s	%s	%s	%s
' "$display" "$raw" "$target" "${path:-}"
    done
}

__fzf_git_worktree_records() {
    emulate -L zsh
    setopt localoptions
    unsetopt xtrace verbose

    local repo_root
    repo_root=$(__fzf_git_repo_root)

    __fzf_git worktree list --porcelain 2>/dev/null |
        awk -v repo_root="$repo_root" '
            function emit() {
                if (path == "") return;
                summary = "";
                if (branch != "") {
                    summary = "branch: " branch;
                } else if (head != "") {
                    summary = "detached: " substr(head, 1, 7);
                } else {
                    summary = "detached";
                }

                meta = "";
                if (locked != "") {
                    meta = "locked";
                }
                if (prunable != "") {
                    if (meta != "") meta = meta ", ";
                    meta = meta prunable;
                }
                if (path == repo_root) {
                    if (meta != "") meta = meta ", ";
                    meta = meta "primary";
                }
                if (meta != "") {
                    summary = summary " [" meta "]";
                }

                split(path, tmp, "/");
                tail = tmp[length(tmp)];
                label = summary " — " tail;
                printf("%s\t%s\t%s\t%s\t%s\n", label, path, branch, head, summary);
            }
            {
                if ($1 == "worktree") {
                    emit();
                    path = substr($0, 10);
                    branch = head = locked = prunable = "";
                } else if ($1 == "branch") {
                    if ($2 ~ /^refs\/heads\//) {
                        branch = substr($2, 12);
                    } else {
                        branch = $2;
                    }
                } else if ($1 == "HEAD") {
                    head = $2;
                } else if ($1 == "locked") {
                    locked = $2;
                } else if ($1 == "prunable") {
                    prunable = $2;
                } else if ($1 == "") {
                    emit();
                    path = branch = head = locked = prunable = "";
                }
            }
            END { emit(); }
        '
}

__fzf_git_worktree_preview() {
    emulate -L zsh
    setopt localoptions
    unsetopt xtrace verbose
    local worktree_path=$1
    local worktree_branch=$2
    local worktree_head=$3

    if [[ -z $worktree_path ]]; then
        echo "No worktree selected"
        return 1
    fi

    if [[ ! -d $worktree_path ]]; then
        echo "Missing worktree path: $worktree_path"
        return 1
    fi

    if [[ -n $worktree_branch ]]; then
        echo "branch: $worktree_branch"
    elif [[ -n $worktree_head ]]; then
        echo "detached at $worktree_head"
    else
        echo "detached worktree"
    fi

    __fzf_git -C "$worktree_path" status -sb 2>/dev/null || echo "(status unavailable)"
    echo
    __fzf_git -C "$worktree_path" log --oneline --decorate --graph -15 --color=always 2>/dev/null || echo "(no commits)"
}

__fzf_git_branch_preview() {
    emulate -L zsh
    setopt localoptions
    unsetopt xtrace verbose
    local raw_branch=$1
    local target_branch=$2
    local worktree_path=$3
    local repo_root
    repo_root=$(__fzf_git_repo_root)

    if [[ -n $worktree_path && -d $worktree_path ]]; then
        echo "worktree: $worktree_path"
        __fzf_git -C "$worktree_path" status -sb 2>/dev/null || echo "(status unavailable)"
        echo
        __fzf_git -C "$worktree_path" log --oneline --decorate --graph -15 --color=always 2>/dev/null || echo "(no commits)"
        return
    fi

    if [[ -z $repo_root ]]; then
        echo "Not inside a git repository"
        return 1
    fi

    local log_ref
    log_ref=$raw_branch
    [[ -z $log_ref ]] && log_ref=$target_branch

    __fzf_git -C "$repo_root" status -sb 2>/dev/null || echo "(status unavailable)"
    echo
    __fzf_git -C "$repo_root" log --oneline --decorate --graph -15 --color=always "$log_ref" 2>/dev/null || echo "(no commits)"
}

__fzf_git_project_preview() {
    emulate -L zsh
    setopt localoptions
    unsetopt xtrace verbose
    local project_path=$1

    if [[ -z $project_path ]]; then
        echo "No project" >&2
        return 1
    fi

    if [[ ! -d $project_path ]]; then
        echo "Missing path: $project_path"
        return 1
    fi

    local repo_root
    repo_root=$(__fzf_git -C "$project_path" rev-parse --show-toplevel 2>/dev/null)
    [[ -z $repo_root ]] && repo_root=$project_path

    eza -la --icons --color=always "$project_path" 2>/dev/null || ls -la "$project_path"
    echo
    __fzf_git -C "$repo_root" status -sb 2>/dev/null && echo
    __fzf_git -C "$repo_root" worktree list 2>/dev/null
}

__fzf_git_discover_projects() {
    emulate -L zsh
    local candidate root_path common_dir abs_common line wt_path
    typeset -A seen_common seen_paths
    seen_common=()
    seen_paths=()

    while IFS= read -r candidate; do
        if [[ -d $candidate ]]; then
            root_path=${candidate%/.git}
        else
            root_path=$(dirname "$candidate")
        fi
        [[ -z $root_path ]] && continue

        common_dir=$(__fzf_git -C "$root_path" rev-parse --git-common-dir 2>/dev/null)
        [[ -z $common_dir ]] && continue

        if abs_common=$(builtin cd -q "$root_path" 2>/dev/null && print -r -- ${common_dir:A}); then
            common_dir=$abs_common
        else
            continue
        fi

        if [[ -n ${seen_common[$common_dir]} ]]; then
            continue
        fi
        seen_common[$common_dir]=1

        while IFS= read -r line; do
            case $line in
                worktree\ *)
                    wt_path=${line#worktree }
                    if [[ -n $wt_path && -z ${seen_paths[$wt_path]} ]]; then
                        seen_paths[$wt_path]=1
                        print -r -- "$wt_path"
                    fi
                    ;;
            esac
        done < <(__fzf_git --git-dir "$common_dir" worktree list --porcelain 2>/dev/null)
    done < <(fd --hidden --follow --glob '.git' ~/Developer ~/Projects 2>/dev/null)
}

fp() {
    local projects
    projects=$(__fzf_git_discover_projects)
    if [[ -z $projects ]]; then
        echo "No git projects found under ~/Developer or ~/Projects"
        return 1
    fi

    local selected_project
    selected_project=$(printf '%s\n' "$projects" |
        FZF_GIT_MODULE_PATH="$__FZF_GIT_MODULE_PATH" \
        FZF_GIT_BIN="$__FZF_GIT_BIN" \
            fzf --bind "esc:abort" \
                --preview "zsh -c 'source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_project_preview \"$1\"' _ {}" \
                --preview-window=right:60%)

    [[ -n $selected_project ]] && cd "$selected_project"
}

gb() {
    if ! command -v git &>/dev/null; then
        echo "git is not installed"
        return 1
    fi

    __fzf_git_collect_worktrees
    local repo_root
    repo_root=$(__fzf_git_repo_root)
    if [[ -z $repo_root ]]; then
        echo "Not inside a git repository"
        return 1
    fi

    local selection
    selection=$(
        __fzf_git_branch_lines |
        FZF_GIT_MODULE_PATH="$__FZF_GIT_MODULE_PATH" \
        FZF_GIT_BIN="$__FZF_GIT_BIN" \
            fzf --delimiter $'	' --with-nth=1 \
                --bind "esc:abort" \
                --preview "zsh -c 'source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_branch_preview \"$1\" \"$2\" \"$3\"' _ {2} {3} {4}"
    )

    [[ -z $selection ]] && return 1

    local display raw target path
    IFS=$'	' read -r display raw target path <<<"$selection"

    if [[ -n $path && $path != $repo_root && -d $path ]]; then
        echo "Branch '$target' is active in worktree: $path"
        __fzf_git_cd_safely "$path"
        return
    fi

    if [[ -n $target ]]; then
        __fzf_git checkout "$target"
    fi
}

gwt_list() {
    if ! command -v git &>/dev/null; then
        echo "git is not installed"
        return 1
    fi

    local repo_root
    repo_root=$(__fzf_git_repo_root)
    if [[ -z $repo_root ]]; then
        echo "Not inside a git repository"
        return 1
    fi

    local selection
    selection=$(
        __fzf_git_worktree_records |
        FZF_GIT_MODULE_PATH="$__FZF_GIT_MODULE_PATH" \
        FZF_GIT_BIN="$__FZF_GIT_BIN" \
            fzf --delimiter $'	' --with-nth=1 \
                --bind "esc:abort" \
                --preview "zsh -c 'source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_worktree_preview \"$1\" \"$2\" \"$3\"' _ {2} {3} {4}"
    )

    [[ -z $selection ]] && return 1

    local display path branch head wt_summary
    IFS=$'	' read -r display path branch head wt_summary <<<"$selection"

    __fzf_git_cd_safely "$path"
}

gwt_add() {
    if ! command -v git &>/dev/null; then
        echo "git is not installed"
        return 1
    fi

    __fzf_git_collect_worktrees
    local repo_root
    repo_root=$(__fzf_git_repo_root)
    if [[ -z $repo_root ]]; then
        echo "Not inside a git repository"
        return 1
    fi

    local selection
    selection=$(
        __fzf_git_branch_lines |
        FZF_GIT_MODULE_PATH="$__FZF_GIT_MODULE_PATH" \
        FZF_GIT_BIN="$__FZF_GIT_BIN" \
            fzf --delimiter $'	' --with-nth=1 \
                --bind "esc:abort" \
                --preview "zsh -c 'source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_branch_preview \"$1\" \"$2\" \"$3\"' _ {2} {3} {4}"
    )

    [[ -z $selection ]] && return 1

    local display raw target existing_path
    IFS=$'	' read -r display raw target existing_path <<<"$selection"

    if [[ -n $existing_path && -d $existing_path ]]; then
        echo "Branch '$target' already has worktree: $existing_path"
        __fzf_git_cd_safely "$existing_path"
        return
    fi

    local sanitized_branch=${target//\//-}
    local base_path="${repo_root:h}/${repo_root:t}-${sanitized_branch}"
    local worktree_path=$base_path
    local suffix=2
    while [[ -e $worktree_path ]]; do
        worktree_path="${base_path}-${suffix}"
        ((suffix++))
    done

    local commitish=$target
    local -a add_args
    add_args=()

    if [[ $raw == remotes/* ]]; then
        commitish=${raw#remotes/}
        if ! __fzf_git show-ref --verify --quiet "refs/heads/$target"; then
            add_args=(-b "$target")
        fi
    fi

    if ! __fzf_git worktree add ${add_args:+${(@)add_args}} "$worktree_path" "$commitish"; then
        echo "Failed to add worktree" >&2
        return 1
    fi

    __fzf_git_cd_safely "$worktree_path"
}

alias gwt-add='gwt_add'
alias gwt-list='gwt_list'

gwt_remove() {
    if ! command -v git &>/dev/null; then
        echo "git is not installed"
        return 1
    fi

    local repo_root
    repo_root=$(__fzf_git_repo_root)
    if [[ -z $repo_root ]]; then
        echo "Not inside a git repository"
        return 1
    fi

    local selection
    selection=$(
        __fzf_git_worktree_records |
        FZF_GIT_MODULE_PATH="$__FZF_GIT_MODULE_PATH" \
        FZF_GIT_BIN="$__FZF_GIT_BIN" \
            fzf --delimiter $'\t' --with-nth=1 \
                --bind "esc:abort" \
                --preview "zsh -c 'source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_worktree_preview \"$1\" \"$2\" \"$3\"' _ {2} {3} {4}"
    )

    [[ -z $selection ]] && return 1

    local display path branch head wt_summary
    IFS=$'\t' read -r display path branch head wt_summary <<<"$selection"

    if [[ -z $path ]]; then
        echo "Missing worktree path" >&2
        return 1
    fi

    if [[ $path == $repo_root ]]; then
        echo "Cannot remove the primary worktree ($path)" >&2
        return 1
    fi

    printf "Remove worktree '%s' (%s)? [y/N] " "$display" "$path"
    local reply
    read -r reply
    [[ ${reply:l} == y* ]] || return 1

    local -a remove_args
    remove_args=(worktree remove)
    if [[ $wt_summary == *locked* || $wt_summary == *prunable* ]]; then
        remove_args+=(--force)
    fi
    remove_args+=("$path")

    if ! __fzf_git "${remove_args[@]}"; then
        echo "Failed to remove worktree" >&2
        return 1
    fi

    echo "Removed worktree '$display'"
    __fzf_git_collect_worktrees >/dev/null 2>&1 || true
}

alias gwt-remove='gwt_remove'

glog() {
    if ! command -v git &>/dev/null; then
        echo "git is not installed"
        return 1
    fi

    git log --oneline --color=always |
        fzf --ansi \
            --bind "esc:abort" \
            --preview "git show --color=always {1}" \
            --preview-window=right:60%
}
