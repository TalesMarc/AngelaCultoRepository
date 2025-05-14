#!/bin/bash

# Caminho para o diretório do seu projeto
cd /Users/tales/angelacultooficial

# Usar o fswatch para monitorar alterações no diretório e subdiretórios
fswatch -o . | while read f
do
  # Adicionar todos os arquivos modificados
  git add .

  # Fazer o commit
  git commit -m "Atualização automática do projeto"

  # Enviar para o GitHub
  git push
done


