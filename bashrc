CHOST="x86_64-pc-linux-gnu"
x86_64_pc_linux_gnu_CFLAGS="-march=native -pipe -O2"
x86_64_pc_linux_gnu_CXXFLAGS="-march=native -pipe -O2"
x86_64_pc_linux_gnu_LDFLAGS="-Wl,-O1 -Wl,--as-needed -Wl,--hash-style=gnu"
i686_pc_linux_gnu_CFLAGS="-march=native -pipe -O2"
i686_pc_linux_gnu_CXXFLAGS="-march=native -pipe -O2"
i686_pc_linux_gnu_LDFLAGS="-Wl,-O1 -Wl,--as-needed -Wl,--hash-style=gnu"


#GIT_WRAPPER="sudo -u hasufell -g paludisbuild"


[[ -e /etc/paludis/hooks/setup_pkg_env.bash ]] && . /etc/paludis/hooks/setup_pkg_env.bash


case "${CATEGORY}/${PN}" in
    x11-wm/i3)
        scm_user_customize () {
            SCM_REPOSITORY="https://github.com/hasufell/i3wm.git"
        }
        ;;
	games-fps/urbanterror)
		EXTRA_WGET="--no-check-certificate"
		;;
esac

# idiotic mysql package dies in pkg_pretend otherwise
MYSQL_MAJOR_UPGRADE="YesPlease"
