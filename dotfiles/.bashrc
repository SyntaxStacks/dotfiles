source ~/.bash_profile
PATH=$PATH:/home/john/applications/node/bin:$HOME/.rvm/bin:/opt/node-v4.2.4-linux-x64/bin:/opt/java/bin # Add RVM to PATH for scripting

function sedReplace () {
  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "\nUsage: sedReplace <sed_string> <path> \nsedString example: \"replace_this/with_that\"\n"
    return 1
  fi

  eval "find $2 -type f -exec sed -i '' 's/$1/g' {} \;"
  return 0
}

function gitWho () {
  eval "git ls-tree -r -z --name-only HEAD -- $* | xargs -0 -n1 git blame \
    --line-porcelain HEAD |grep  \"^author \"|sort|uniq -c|sort -nr"
}

function whatTheFuckAreWeReleasingThisTime () {
  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "\nUsage: whatTheFuckAreWeReleasingThisTime <last release #> <current release #> "
    return 1
  fi
  eval "git log --pretty=format:\"%h - %an: %s\"  --abbrev-commit upstream/Release_$1...upstream/Release_$2\
    | grep -Eo \"((?:DCXAPPS|EN)[-]\d+)\" | sort | uniq"
}
