#!/bin/bash

readonly ROOT=$(cd $(dirname ${BASH_SOURCE:-$0})/.. ; pwd)
readonly TARGETS=$(cd $ROOT; find . -name '.git' -prune -o -name '.script' -prune -o -type f -name '*.html' -print)

cd $ROOT

for target in $TARGETS
do
    first=$(grep '<nav' -n $target | cut -d':' -f1)
    end=$(grep '</nav' -n $target | cut -d':' -f1)

    tempFile=$(mktemp)

    {
        sed "${first},\$d" $target
        cat << 'EOT'
      <nav class="navigation">
        <div class="to-root">
          <a href="/index.html" >
            <img src="https://s.gravatar.com/avatar/6b05605bbb3b40e2f897d6347dd92b2d?s=40" />
            <span>Yajamon</span>
          </a>
        </div>
        <div class="stretch-space"></div>
        <a href="/donation.html">
          Donation
        </a>
      </nav>
EOT
        sed "1,${end}d" $target
    } > $tempFile

    cp $tempFile $target
    rm $tempFile
done
