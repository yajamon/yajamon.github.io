#!/bin/bash

readonly ROOT=$(cd $(dirname ${BASH_SOURCE:-$0})/.. ; pwd)
readonly TARGETS=$(cd $ROOT; find . -name '.git' -prune -o -name '.script' -prune -o -type f -name '*.html' -print)

cd $ROOT

target='index.html'

first=$(grep '<nav' -n $target | cut -d':' -f1)
end=$(grep '</nav' -n $target | cut -d':' -f1)

sed "${first},${end}d" index.html | sed "${first}i\\"'
      <nav class="navigation">
        <div class="to-root">
          <a href="/" >
            <img src="https://s.gravatar.com/avatar/6b05605bbb3b40e2f897d6347dd92b2d?s=40" />
            <span>Yajamon</span>
          </a>
        </div>
        <div class="stretch-space"></div>
      </nav>
'
