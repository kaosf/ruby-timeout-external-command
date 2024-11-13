#!/bin/bash

if [ $1 -gt 2 ]; then
  while :; do
    sleep 1
  done
fi

sleep 1
echo "Finish this command ($1)"
