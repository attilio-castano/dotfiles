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

__fzf_git_branch_preview() {
    emulate -L zsh
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
                --preview 'zsh -c "source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_project_preview \"$1\"" _ {}' \
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
        {
            emulate -L zsh
            local raw
            local -a locals remotes
            while IFS= read -r raw; do
                [[ -z $raw ]] && continue
                if [[ $raw == remotes/* ]]; then
                    remotes+=$raw
                else
                    locals+=$raw
                fi
            done < <(__fzf_git branch -a --no-color 2>/dev/null | grep -v HEAD | sed 's/^[*+ ]*//' | sort -u)

            local branch target path display
            for raw in "${locals[@]}" "${remotes[@]}"; do
                [[ -z $raw ]] && continue
                target=$raw
                if [[ $raw == remotes/* ]]; then
                    target=${raw#remotes/}
                    target=${target#*/}
                fi
                path=${__FZF_GIT_WORKTREES[$target]}

                if [[ $raw == remotes/* ]]; then
                    display=${raw#remotes/}
                else
                    display=$target
                fi

                local -a annotations
                annotations=()
                if [[ -n $path ]]; then
                    if [[ $path == $repo_root ]]; then
                        annotations+=(current)
                    else
                        annotations+=("wt:${path:t}")
                    fi
                fi
                if [[ $raw == remotes/* ]]; then
                    annotations+=(remote)
                fi
                if (( ${#annotations} )); then
                    display+=" — ${(j:, :)annotations}"
                fi

                printf '%s\t%s\t%s\t%s\n' "$display" "$raw" "$target" "${path:-}"
            done
        } |
        FZF_GIT_MODULE_PATH="$__FZF_GIT_MODULE_PATH" \
        FZF_GIT_BIN="$__FZF_GIT_BIN" \
            fzf --delimiter $'\t' --with-nth=1 \
                --bind "esc:abort" \
                --preview 'zsh -c "source \"$FZF_GIT_MODULE_PATH\"; __fzf_git_branch_preview \"$1\" \"$2\" \"$3\"" _ {2} {3} {4}'
    )

    [[ -z $selection ]] && return 1

    local display raw target path
    IFS=$'\t' read -r display raw target path <<<"$selection"

    if [[ -n $path && $path != $repo_root && -d $path ]]; then
        echo "Branch '$target' is active in worktree: $path"

        local restore_zoxide=0
        local -a saved_chpwd_functions
        if (( ${+functions[__zoxide_hook]} )) && ! command -v zoxide >/dev/null 2>&1; then
            saved_chpwd_functions=(${chpwd_functions[@]})
            chpwd_functions=(${chpwd_functions:#__zoxide_hook})
            restore_zoxide=1
        fi

        builtin cd "$path"

        if (( restore_zoxide )); then
            chpwd_functions=(${saved_chpwd_functions[@]})
        fi
        return
    fi

    if [[ -n $target ]]; then
        __fzf_git checkout "$target"
    fi
}

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
