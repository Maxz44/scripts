#!/bin/bash
# Gui script to generate a password
set -e

type zenity xclip > /dev/null

format=$(zenity --entry --entry-text='a-zA-Z0-9-_$@#&' --text=Format)
size=$(zenity --entry --entry-text=15 --text=Taille)

cat /dev/urandom|tr -dc "${format}"|fold -w "${size}"|head -n 100|zenity --list --column=pw|tr -d '\n'|xclip -selection c
zenity --info --text="le mot de passe a été copié dans le presse papier"