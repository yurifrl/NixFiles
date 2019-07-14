function __theme_afolwer_short_pwd
	pwd | sed -e 's>'"$HOME"'>~>' | tr / \n | tac | head -n 3 | tac | tr \n / | sed -e 's/\/$//'
end

function __theme_afowler_git_prompt
	set -l git_status (git status -z --porcelain 2>&1)
	if test $status -eq 0
		set -l raw_ref (command git symbolic-ref HEAD 2> /dev/null; or command git rev-parse --short HEAD 2> /dev/null)
		set -l ref (echo -n $raw_ref | sed -e 's|refs/heads/||')
		set -l dirty (test (count $git_status) -gt 0; and echo -n "*")
		echo -n " $argv[1]$ref$dirty$argv[2]"
	end
end

function __current_context
  echo -n (grep -Po '(?<=current-context:).*'  ~/.kube/config | xargs)
end

function fish_prompt
	echo -n (hostname)
	set_color --bold blue
	echo -n "/"
	set_color normal
	echo -n (__current_context)
	set_color --bold blue
	echo -n " :: "
	set_color green
	echo -n (__theme_afolwer_short_pwd)
	set_color yellow
	__theme_afowler_git_prompt "‹" "›"
	set_color --bold blue
	echo '» '
end
