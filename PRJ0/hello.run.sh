# Correct code here for one cycle
echo 'Running the gcc for hello1.c'
#/mipsroot/cross-tools/bin/mips-unknown-linux-gnu-gcc -O0 -g -static -mabi=32 -fno-delayed-branch -fno-optimize-sibling-calls -msplit-addresses -march=mips4 -ohello1.mipseb hello1.c
echo 'Generate the report for hello1.c'
#~/sesc/sesc.opt -fhello1.rpt -c ~/sesc/confs/cmp4-noc.conf -ohello1.out hello1.mipseb
echo 'Outputting the report to results.txt'
#~/sesc/scripts/report.pl sesc_hello1.mipseb.hello1.rpt >> hello1.results.txt

function main
{
  for i in $(seq 1 9);
  do
    echo "Running the gcc for hello$i.c"
    /mipsroot/cross-tools/bin/mips-unknown-linux-gnu-gcc -O0 -g -static -mabi=32 -fno-delayed-branch -fno-optimize-sibling-calls -msplit-addresses -march=mips4 -ohello$i.mipseb hello$i.c
    echo "Generate the report for hello$i.c"
    ~/sesc/sesc.opt -fhello$i.rpt -c ~/sesc/confs/cmp4-noc.conf -ohello$i.out hello$i.mipseb
    echo "Outputting the report to hello$i.results.txt"
    ~/sesc/scripts/report.pl sesc_hello.mipseb.hello$i.rpt > hello$i.results.txt
    echo ""
    echo ""
  done
}

function compile
{
  rm hello.run.log
  for j in $(seq 1 9);
  do
    cat hello$j.results.txt >> hello.run.log
  done
}

echo "~~~~ Starting Main ~~~~"
echo "This is a little expirement I am trying to see how the nInst is changed for printf in c"
echo "by TeeJ"
echo ""
main
compile
echo "~~~~ Finishing Main ~~~~"
