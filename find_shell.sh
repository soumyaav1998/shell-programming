#!/bin/bash
echo "prints parent shell $$"
(
    echo "prints child shell $PPID"
)
