#!/bin/bash

# chmod 755 ~/autorelease/compare.sh
# crontab -e
# * * * * * cd [path git service source] && git pull > [log]
# ~/autorelease/compare.sh ~/autorelease/old.dt ~/autorelease/new.dt /[path git service source]/.git/index ~/autorelease/crontab.dt

ARGS=4 # 4개의 인자가 필요.
E_BADARGS=65

if [ $# -ne "$ARGS" ]
then
  echo "사용법: `basename $0` file1 file2 file3 file4"
  exit $E_BADARGS
fi

#ls -l $3 | sed -E  's/(.*)$4 (.*)/\2/' > $2 #일단 보류
ls -l $3 > $2

cmp $1 $2 > /dev/null  # /dev/null 은 "cmp"의 출력을 안 보이게 해줍니다.
# 'diff'에서도 동작합니다. 즉, diff $1 $2 > /dev/null 

if [ $? -eq 0 ] # "cmp"의 종료 상태를 확인.
then
  echo "\"$1\" 은 \"$2\" 변함 없음 배포안함" > $4
else
  echo "\"$1\" 은 \"$2\" 변화가 있음 배포시나리오 실행" > $4
  ls -l $3 > $1
  #배포시나리오

fi

exit 0
