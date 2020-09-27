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
  echo "~~~~~  NOT TAKEN  ~~~~~" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt

  cd ~/sesc/apps/Splash2/lu
  cp ~/Repos/HPCA/PRJ1/trial3/cmp4-noc-nta.conf ~/sesc/confs/cmp4-noc-nta.conf
  rm ~/sesc/apps/Splash2/lu/sesc_lu.mipseb.n32.rpt
  ~/sesc/sesc.opt -fn32.rpt -c ~/sesc/confs/cmp4-noc.conf -olu.out -elu.err lu.mipseb -n32 -p1
  rm ~/Repos/HPCA/PRJ1/trial3/sesc_lu.mipseb.n32.rpt
  cp ~/sesc/apps/Splash2/lu/sesc_lu.mipseb.n32.rpt ~/Repos/HPCA/PRJ1/trial3/
  ~/sesc/scripts/report.pl ~/Repos/HPCA/PRJ1/trial3/sesc_lu.mipseb.n32.rpt >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "~~~~~  NOT TAKEN ~~~~~~" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial3/results_lu.txt

    # run simulation for oracle case
  # echo "~~~~~  NOT TAKEN  ~~~~~" >> ~/Repos/HPCA/PRJ1/trial3/results.txt
  # cd ~/sesc/apps/Splash2/raytrace
  # cp ~/Repos/HPCA/PRJ1/trial3/cmp4-noc-nta.conf ~/sesc/confs/cmp4-noc-nta.conf
  # rm ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.NTA
  # ~/sesc/sesc.opt -f NTA -c ~/sesc/confs/cmp4-noc-nta.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
  # rm ~/Repos/HPCA/PRJ1/trial3/sesc_raytrace.mipseb.NTA
  # cp ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.NTA ~/Repos/HPCA/PRJ1/trial3/
  # ~/sesc/scripts/report.pl ~/Repos/HPCA/PRJ1/trial3/sesc_raytrace.mipseb.NTA >> ~/Repos/HPCA/PRJ1/trial3/results.txt
  # echo "~~~~~  NOT TAKEN ~~~~~~" >> ~/Repos/HPCA/PRJ1/trial3/results.txt
  # echo "" >> ~/Repos/HPCA/PRJ1/trial3/results.txt
  # echo "" >> ~/Repos/HPCA/PRJ1/trial3/results.txt

}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ1."
echo "by TeeJ"
echo ""
simulate
echo "~~~~ Finishing Main ~~~~"
