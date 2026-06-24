# Launch Yazi and change this shell to Yazi's final working directory.
function y() {
	local cwd_file cwd yazi_status

	cwd_file="$(mktemp -t yazi-cwd.XXXXXX)" || return 1

	command yazi "$@" --cwd-file="$cwd_file"
	yazi_status=$?

	cwd="$(<"$cwd_file")"
	if [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]]; then
		builtin cd -- "$cwd"
	fi

	command rm -f -- "$cwd_file"
	return "$yazi_status"
}
