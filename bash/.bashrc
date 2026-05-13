# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/ben/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="font"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

# echo "setting up nvm..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# echo "setting up ansible..."
# source ~/venvs/venv3_ansible-7.4.0/bin/activate
source ~/venvs/venv_ansible/bin/activate
source ~/workspace/kiewit/molecule

# echo "setting up java..."
export JDK_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export JAVA_HOME=$JDK_HOME
export PIP_NO_BINARY=jpy

# echo "setting up local bin path..."
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/bin

# echo "setting up maven..."
export M2_HOME=/usr/local/apache-maven/apache-maven-3.9.6
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms256m -Xmx512m"
export PATH=$M2:$PATH

# echo "setting up aliases..."
export EDITOR=$HOME/bin/nvim
export PAGER=most
alias vi=nvim
alias vim=nvim
alias tldrf='tldr -l -1 | fzf --preview "tldr {1}" --preview-window=right,80% | xargs tldr -t base16'
# export MANPAGER='nvim +Man!'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# echo "setting up k8s..."
export PATH=$HOME/.krew/bin:$PATH
source <(/home/ben/bin/kubectl completion bash)
#source <(/home/ben/bin/helm completion bash)
#source <(/usr/local/bin/flux completion bash)

# echo "setting up go..."
. "$HOME/.cargo/env"
export PATH=$HOME/go/bin:/usr/local/go/bin:$PATH

# echo "setting up zoxide..."
_z_cd() {
  cd "$@" || return "$?"

  if [ "$_ZO_ECHO" = "1" ]; then
    echo "$PWD"
  fi
}

z() {
  if [ "$#" -eq 0 ]; then
    _z_cd ~
  elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
    if [ -n "$OLDPWD" ]; then
      _z_cd "$OLDPWD"
    else
      echo 'zoxide: $OLDPWD is not set'
      return 1
    fi
  else
    _zoxide_result="$(zoxide query -- "$@")" && _z_cd "$_zoxide_result"
  fi
}

zi() {
  _zoxide_result="$(zoxide query -i -- "$@")" && _z_cd "$_zoxide_result"
}

alias za='zoxide add'

alias zq='zoxide query'
alias zqi='zoxide query -i'

alias zr='zoxide remove'
zri() {
  _zoxide_result="$(zoxide query -i -- "$@")" && zoxide remove "$_zoxide_result"
}

_zoxide_hook() {
  if [ -z "${_ZO_PWD}" ]; then
    _ZO_PWD="${PWD}"
  elif [ "${_ZO_PWD}" != "${PWD}" ]; then
    _ZO_PWD="${PWD}"
    zoxide add "$(pwd -L)"
  fi
}

case "$PROMPT_COMMAND" in
*_zoxide_hook*) ;;
*) PROMPT_COMMAND="_zoxide_hook${PROMPT_COMMAND:+;${PROMPT_COMMAND}}" ;;
esac

# echo "setting up dog..."
_dog() {
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD - 1]}

  case "$prev" in
  -'?' | --help | -v | --version)
    return
    ;;

  -t | --type)
    COMPREPLY=($(compgen -W 'A AAAA CAA CNAME HINFO MX NS PTR SOA SRV TXT' -- "$cur"))
    return
    ;;

  --edns)
    COMPREPLY=($(compgen -W 'disable hide show' -- "$cur"))
    return
    ;;

  -Z)
    COMPREPLY=($(compgen -W 'aa ad bufsize= cd' -- "$cur"))
    return
    ;;

  --class)
    COMPREPLY=($(compgen -W 'IN CH HS' -- "$cur"))
    return
    ;;

  --color | --colour)
    COMPREPLY=($(compgen -W 'always automatic never' -- $cur))
    return
    ;;
  esac

  case "$cur" in
  -*)
    COMPREPLY=($(compgen -W '$( _parse_help "$1" )' -- "$cur"))
    return
    ;;

  *)
    COMPREPLY=($(compgen -W 'A AAAA CAA CNAME HINFO MX NS PTR SOA SRV TXT' -- "$cur"))
    ;;
  esac
} &&
  complete -o bashdefault -F _dog dog

# echo "setting up yazi..."
_yazi() {
  local i cur prev opts cmd
  COMPREPLY=()
  if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
    cur="$2"
  else
    cur="${COMP_WORDS[COMP_CWORD]}"
  fi
  prev="$3"
  cmd=""
  opts=""

  for i in "${COMP_WORDS[@]:0:COMP_CWORD}"; do
    case "${cmd},${i}" in
    ",$1")
      cmd="yazi"
      ;;
    *) ;;
    esac
  done

  case "${cmd}" in
  yazi)
    opts="-V -h --cwd-file --chooser-file --clear-cache --client-id --local-events --remote-events --debug --version --help [ENTRIES]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --cwd-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --chooser-file)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --client-id)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --local-events)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --remote-events)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
  complete -F _yazi -o nosort -o bashdefault -o default yazi
else
  complete -F _yazi -o bashdefault -o default yazi
fi

_ya() {
  local i cur prev opts cmd
  COMPREPLY=()
  if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
    cur="$2"
  else
    cur="${COMP_WORDS[COMP_CWORD]}"
  fi
  prev="$3"
  cmd=""
  opts=""

  for i in "${COMP_WORDS[@]:0:COMP_CWORD}"; do
    case "${cmd},${i}" in
    ",$1")
      cmd="ya"
      ;;
    ya,emit)
      cmd="ya__emit"
      ;;
    ya,emit-to)
      cmd="ya__emit__to"
      ;;
    ya,help)
      cmd="ya__help"
      ;;
    ya,pack)
      cmd="ya__pack"
      ;;
    ya,pkg)
      cmd="ya__pkg"
      ;;
    ya,pub)
      cmd="ya__pub"
      ;;
    ya,pub-to)
      cmd="ya__pub__to"
      ;;
    ya,sub)
      cmd="ya__sub"
      ;;
    ya__help,emit)
      cmd="ya__help__emit"
      ;;
    ya__help,emit-to)
      cmd="ya__help__emit__to"
      ;;
    ya__help,help)
      cmd="ya__help__help"
      ;;
    ya__help,pack)
      cmd="ya__help__pack"
      ;;
    ya__help,pkg)
      cmd="ya__help__pkg"
      ;;
    ya__help,pub)
      cmd="ya__help__pub"
      ;;
    ya__help,pub-to)
      cmd="ya__help__pub__to"
      ;;
    ya__help,sub)
      cmd="ya__help__sub"
      ;;
    ya__help__pkg,add)
      cmd="ya__help__pkg__add"
      ;;
    ya__help__pkg,delete)
      cmd="ya__help__pkg__delete"
      ;;
    ya__help__pkg,install)
      cmd="ya__help__pkg__install"
      ;;
    ya__help__pkg,list)
      cmd="ya__help__pkg__list"
      ;;
    ya__help__pkg,upgrade)
      cmd="ya__help__pkg__upgrade"
      ;;
    ya__pkg,add)
      cmd="ya__pkg__add"
      ;;
    ya__pkg,delete)
      cmd="ya__pkg__delete"
      ;;
    ya__pkg,help)
      cmd="ya__pkg__help"
      ;;
    ya__pkg,install)
      cmd="ya__pkg__install"
      ;;
    ya__pkg,list)
      cmd="ya__pkg__list"
      ;;
    ya__pkg,upgrade)
      cmd="ya__pkg__upgrade"
      ;;
    ya__pkg__help,add)
      cmd="ya__pkg__help__add"
      ;;
    ya__pkg__help,delete)
      cmd="ya__pkg__help__delete"
      ;;
    ya__pkg__help,help)
      cmd="ya__pkg__help__help"
      ;;
    ya__pkg__help,install)
      cmd="ya__pkg__help__install"
      ;;
    ya__pkg__help,list)
      cmd="ya__pkg__help__list"
      ;;
    ya__pkg__help,upgrade)
      cmd="ya__pkg__help__upgrade"
      ;;
    *) ;;
    esac
  done

  case "${cmd}" in
  ya)
    opts="-V -h --version --help emit emit-to pkg pack pub pub-to sub help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__emit)
    opts="-h --help <NAME> [ARGS]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__emit__to)
    opts="-h --help <RECEIVER> <NAME> [ARGS]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help)
    opts="emit emit-to pkg pack pub pub-to sub help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__emit)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__emit__to)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pack)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pkg)
    opts="add delete install list upgrade"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pkg__add)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pkg__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pkg__install)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pkg__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pkg__upgrade)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pub)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__pub__to)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__help__sub)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pack)
    opts="-a -d -i -l -u -h --add --delete --install --list --upgrade --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --add)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -a)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --delete)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg)
    opts="-h --help add delete install list upgrade help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__add)
    opts="-h --help [IDS]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__delete)
    opts="-h --help [IDS]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help)
    opts="add delete install list upgrade help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help__add)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help__install)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__help__upgrade)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__install)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__list)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pkg__upgrade)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pub)
    opts="-h --str --json --list --help <KIND>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --str)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --json)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --list)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__pub__to)
    opts="-h --str --json --list --help <RECEIVER> <KIND>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --str)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --json)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --list)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  ya__sub)
    opts="-h --help <KINDS>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
  complete -F _ya -o nosort -o bashdefault -o default ya
else
  complete -F _ya -o bashdefault -o default ya
fi

export PATH=$PATH:/home/ben/.runai/bin
source <(/home/ben/.runai/bin/runai completion bash)
source <(/home/ben/bin/runai-adm completion bash)

# A little gemini chat alias
# Automatically saves the current project session to a dated file
alias gsave='gemini export --format markdown > "chat-$(date +%Y-%m-%d_%H%M).md"'

# echo "bashrc done"
