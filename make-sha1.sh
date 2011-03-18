#!/bin/bash
make_sha1()
{
  sha1sum $1 | awk '{print $1}' > $1.sha1
}

if [ ! -e "$1.sha1" ]; then
  make_sha1 $1
  echo "Generated sha1 for $1"
fi

if [ ! -s "$1.sha1" ]; then
  make_sha1 $1
  echo "Re-generated SHA1 for zero-length sha1 file $1"
fi
