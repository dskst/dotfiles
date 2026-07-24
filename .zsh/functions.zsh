function suggest {
  local system_prompt="あなたはmacOS/zsh環境向けのシェルコマンドを提案するツールである。
ユーザーが入力した要件を満たすコマンドと50文字以内の説明文のみを出力する。
前置き、後置き、Markdownのコードブロック記法は一切含めない。
複数の候補がある場合は、コマンドを改行で列挙する。

出力例:
{コマンド}
{説明分}
"
  claude -p "$*" \
    --model haiku \
    --system-prompt "$system_prompt" \
    --output-format stream-json \
    --include-partial-messages \
    --verbose |
  while IFS= read -r line; do
    printf "%s" "$(
      jq -r 'select(.event.type=="content_block_delta" and .event.delta.type=="text_delta") | .event.delta.text // empty' <<<"$line"
    )"
  done
  echo
}

function gwt {
  local branch="" remove=false
  local -a force copies
  while (( $# )); do
    case "$1" in
      --remove) remove=true ;;
      --force)  force=(--force) ;;
      --copy)
        if (( $# < 2 )); then
          echo "gwt: --copy requires a file path" >&2
          return 1
        fi
        shift
        copies+=("${1%/}")
        ;;
      *)        branch="$1" ;;
    esac
    shift
  done

  if $remove; then
    local main_dir
    main_dir="$(git worktree list --porcelain | head -1 | cut -d' ' -f2-)" || return

    if [[ -n "$branch" ]]; then
      git worktree remove "${force[@]}" "../$(basename "$PWD")_${branch//\//_}" || return
    else
      local current
      current="$(git rev-parse --show-toplevel)" || return
      if [[ "$current" == "$main_dir" ]]; then
        echo "gwt: specify the branch name of the worktree to remove" >&2
        return 1
      fi
      branch="$(git rev-parse --abbrev-ref HEAD)" || return
      cd "$main_dir" || return
      git worktree remove "${force[@]}" "$current" || return
    fi

    if ! git branch -d "$branch"; then
      echo "gwt: branch '$branch' is kept; run 'git branch -D $branch' to force-delete" >&2
    fi
    return
  fi

  if [[ -z "$branch" ]]; then
    echo "usage: gwt <branch> [--copy <path>]... [--remove [--force]]" >&2
    return 1
  fi

  local dir="../$(basename "$PWD")_${branch//\//_}"

  if git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
    git fetch origin "$branch" || return
    git worktree add --track -b "$branch" "$dir" "origin/$branch" || return
  else
    git worktree add -b "$branch" "$dir" || return
  fi

  (
    setopt nullglob
    cp -a .env .env.* .envrc "$dir/" 2>/dev/null || true
  )

  local src
  for src in "${copies[@]}"; do
    if [[ ! -e "$src" ]]; then
      echo "gwt: --copy: '$src' not found; skipped" >&2
      continue
    fi
    mkdir -p "$dir/$(dirname "$src")"
    cp -a "$src" "$dir/$(dirname "$src")/"
  done

  command -v direnv >/dev/null && direnv allow "$dir"

  cd "$dir"
}


fssh() {
  grep -i '^host [^*]' ~/.ssh/config ~/.ssh/conf.d/hosts/* | cut -d ' ' -f 2 | fzf | xargs -o ssh
}

function catcp {
  cat "$@" | pbcopy
}
