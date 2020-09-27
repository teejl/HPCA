function simulate
{
  # clear results_lu.txt
  echo "Simulation executing..." > ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "" >> results_lu.txt

  rm ~/sesc/src/libcore/BPred.cpp
  rm ~/sesc/src/libcore/BPred.h
  cp ~/Repos/HPCA/PRJ1/trial3/BPred.cpp ~/sesc/src/libcore/BPred.cpp
  cp ~/Repos/HPCA/PRJ1/trial3/BPred.h ~/sesc/src/libcore/BPred.h

  cd ~/sesc/
  make

  # run simulation for hybrid case
  echo "~~~~~  HYBRID  ~~~~~" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt

  cd ~/sesc/apps/Splash2/lu
  cp ~/Repos/HPCA/PRJ1/trial3/cmp4-noc.conf ~/sesc/confs/cmp4-noc.conf
  rm ~/sesc/apps/Splash2/lu/sesc_lu.mipseb.n32.rpt
  ~/sesc/sesc.opt -fn32.rpt -c ~/sesc/confs/cmp4-noc.conf -olu.out -elu.err lu.mipseb -n32 -p1
  rm ~/Repos/HPCA/PRJ1/trial3/sesc_lu.mipseb.n32.rpt
  cp ~/sesc/apps/Splash2/lu/sesc_lu.mipseb.n32.rpt ~/Repos/HPCA/PRJ1/trial3/
  ~/sesc/scripts/report.pl ~/Repos/HPCA/PRJ1/trial3/sesc_lu.mipseb.n32.rpt >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "~~~~~  HYBRID ~~~~~~" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt

}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ1."
echo "by TeeJ"
echo ""
simulate
echo "~~~~ Finishing Main ~~~~"
