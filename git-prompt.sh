if test -f /etc/profile.d/git-sdk.sh 
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

_git_repo_name() { 
    gittopdir=$(git rev-parse --git-dir 2> /dev/null)
    if [[ "foo$gittopdir" == "foo.git" ]]; then
        echo `basename $(pwd)`
    elif [[ "foo$gittopdir" != "foo" ]]; then
        echo `dirname $gittopdir | xargs basename`
    fi
}

_git_branch_name() {    
    git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}

if [ -z "$(_git_repo_name)" ] 
then
	_git_repo_name_exist=""
else
	_git_repo_name_exist="\[\033[01;34m\]repo:(\[\033[01;31m\]$(_git_repo_name)\[\033[01;34m\])\[\033[01;00m\]"
fi

if [ -z "$(_git_branch_name)" ] 
then
	_git_branche_name_exist=""
else
	_git_branche_name_exist=" \[\033[01;34m\]branche:(\[\033[01;31m\]$(_git_branch_name)\[\033[01;34m\])\[\033[01;00m\] "
fi
MSYS2_PS1="\[\033[36m\]\w $_git_repo_name_exist$_git_branche_name_exist\[\033[33m\]→\[\033[01;00m\] "