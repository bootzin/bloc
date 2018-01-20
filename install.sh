#!/bin/bash
#
# bloc installer script

installPath="$1"
dbPath="$2/bloc.db"

echo "exporting $installPath into $PATH"
export $PATH=$PATH:$installPath
echo "Installing bloc"
replace "#DEFAULT" "$dbPath" -- ./bloc
replace "#DEFAULT" "$dbPath" -- ./bloc-populate
echo "linking bloc from current folder into $installPath"
ln -s ./bloc $installPath/bloc
echo "linking bloc-populate from current folder into $installPath"
ln -s ./bloc-populate $installPath/bloc-populate
echo "Populating bloc database"
bloc-populate -o $dbPath -v
