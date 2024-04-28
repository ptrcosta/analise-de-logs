#!/bin/bash

# loganalyze.sh - Filtro para analise de logs do arquivo access.log
# Pedro - Abr 2024 - v2.0

# [MELHORIAS]
# 1 - Identificar quantos hosts tem no total
# 2 - Identificar o host que tem mais requisicoes (atacante)
# 3 - Marcar a hora de inicio e fim do ataque

### INICIO DO SCRIPT ###
echo "Digite o caminho de origem - [EXEMPLO: /home/sec/lab/1_analise_de_logs/access.log]"
read path
echo "Digite onde sera gravado o arquivo de analise"
read file

awk -F" " '{print $1}' $path | sort | uniq -c | sort > $file

### EXIBICAO DO RESULTADO ###
nhost=`cat $file | wc -l`
ip=`tail -n1 $file | cut -d " " -f4,5,6`
begin=`grep "177.138.28.7" $path | head -n1 | awk -F " " '{print "Inicio do ataque " $4$5}'` 
end=`grep "177.138.28.7" $path | tail -n1 | awk -F " " '{print "Fim do ataque " $4$5}'` 
dir=`grep "205.251.150.186" $path | grep "GET" | grep "200" | cut -d '"' -f2 | grep "configuracoes"`

echo -e "\nHosts: "$nhost >> $file
echo "IP: "$ip >> $file
echo $begin >> $file
echo $end >> $file
echo $dir >> $file
