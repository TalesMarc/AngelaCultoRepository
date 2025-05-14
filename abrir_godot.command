#!/bin/zsh
cd /Users/tales/angelacultooficial

# Inicia o script de atualização Git em segundo plano
./auto_update_git.sh &

# Abre o Godot com seu projeto
open -a "Godot" /Users/tales/angelacultooficial/project.godot

