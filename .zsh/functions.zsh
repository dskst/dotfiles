function suggest {
  local system_prompt="あなたはmacOS/zsh環境向けのシェルコマンドを提案するツールである。
ユーザーが入力した要件を満たすコマンドのみを出力する。
説明文、前置き、後置き、Markdownのコードブロック記法は一切含めない。
複数の候補がある場合は、コマンドを改行で列挙する。"
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

function worktree {
  local branch="$1"
  local dir="../$(basename "$PWD")_${branch//\//_}"

  git worktree add "$dir" "origin/$branch" || return

  (
    setopt nullglob
    cp -a .env .env.* .envrc "$dir/" 2>/dev/null || true
  )

  command -v direnv >/dev/null && direnv allow "$dir"

  cd "$dir"
}


fssh() {
  grep -i '^host [^*]' ~/.ssh/config ~/.ssh/conf.d/hosts/* | cut -d ' ' -f 2 | fzf | xargs -o ssh
}

function catcp {
  cat "$@" | pbcopy 
}
