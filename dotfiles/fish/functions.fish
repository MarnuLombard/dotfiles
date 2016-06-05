###############
## FUNCTIONS
###############


### Filesystem
function md
  mkdir $argv;
  cd $argv;
end

### Git
function gitpp
  gmfforrb master; and git push origin master; or echo "Failed to Pull, not Pushing to server..."
end

function gmff
  git fetch origin $argv; and git merge --ff-only origin/$argv;
end

function grb
  git stash; and git rebase origin/master; and git stash pop;
end

function gmfforrb
  gmff $argv; or grb $argv;
end


function gg
  gmff master; git gui; git push origin master;
end

### Advanced GIT Stuff ##

function __git_ps1
  set -l g (git rev-parse --git-dir ^/dev/null)
  if [ -n "$g" ]
    set -l r ""
    set -l b ""

    if [ -d "$g/../.dotest" ]
      if [ -f "$g/../.dotest/rebasing" ]
        set r "|REBASE"
      elseif [ -f "$g/../.dotest/applying" ]
        set r "|AM"
      else
        set r "|AM/REBASE"
      end

      set b (git symbolic-ref HEAD ^/dev/null)
    elseif [ -f "$g/.dotest-merge/interactive" ]
      set r "|REBASE-i"
      set b (cat "$g/.dotest-merge/head-name")
    elseif [ -d "$g/.dotest-merge" ]
      set r "|REBASE-m"
      set b (cat "$g/.dotest-merge/head-name")
    elseif [ -f "$g/MERGE_HEAD" ]
      set r "|MERGING"
      set b (git symbolic-ref HEAD ^/dev/null)
    else
      if [ -f "$g/BISECT_LOG" ]
              set r "|BISECTING"
      end

      set b (git symbolic-ref HEAD ^/dev/null)
      if [ -z $b ]
        set b (git describe --exact-match HEAD ^/dev/null)
        if [ -z $b ]
          set b (cut -c1-7 "$g/HEAD")
          set b "$b..."
        end
      end
    end

    if not test $argv
        set argv "%s:%s%s" (set_color normal) (set_color purple) $argv
    end

    set b (echo $b | sed -e 's|^refs/heads/||')

    printf $argv "$b$r" ^/dev/null
  end
end

function git_dirty
  if not is_git_repo
    return 1
  end
  not git diff HEAD --quiet ^/dev/null
end

function is_git_repo
  git status >/dev/null ^/dev/null
  not test $status -eq 128
end
