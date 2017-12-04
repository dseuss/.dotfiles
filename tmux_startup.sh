
# [tmux] load scripts in ~/.tmux on creating a new pane
# load order: __before__.sh, ${session_name}.sh, __after__.sh
# https://unix.stackexchange.com/questions/80473/how-do-i-run-a-shell-command-from-tmux-conf
function tmux_load_startup_scripts_by_session_name() {
  if [[ -n ${TMUX} ]]; then
    local env_before_script="${HOME}/.tmux/__before__.sh"
    [[ -f "${env_before_script}" ]] && { . "${env_before_script}"; }
    local env_main_script="${HOME}/.tmux/$(tmux display-message -p '#{session_name}').sh"
    [[ -f "${env_main_script}" ]] && { . "${env_main_script}"; }
    local env_after_script="${HOME}/.tmux/__after__.sh"
    [[ -f "${env_after_script}" ]] && { . "${env_after_script}"; }
  fi
}
tmux_load_startup_scripts_by_session_name
