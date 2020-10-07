function simulate
{
  # clear results.txt
  echo "Simulation executing..." > ~/Repos/HPCA/PRJ2/trial1/results.txt
  echo "" >> results.txt

  # resetting the configuration files
  rm ~/sesc/src/libcore/BPred.cpp
  rm ~/sesc/src/libcore/BPred.h
  rm ~/sesc/confs/cmp4-noc.conf
  cp ~/Repos/HPCA/PRJ2/SESC_original_files/BPred.cpp ~/sesc/src/libcore/BPred.cpp
  cp ~/Repos/HPCA/PRJ2/SESC_original_files/BPred.h ~/sesc/src/libcore/BPred.h
  cp ~/Repos/HPCA/PRJ2/SESC_original_files/cmp4-noc.conf ~/sesc/confs/cmp4-noc.conf

  # build out simulator
  cd ~/sesc/
  make

  # run simulation for hybrid case
  echo "~~~~~  HYBRID  ~~~~~" >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  
  # build the simulation
  cd ~/sesc/apps/Splash2/fmm
  make

  # remove output, run simulation, and copy it to the trail folder
  rm ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb.Default
  ~/sesc/sesc.opt -f Default -c ~/sesc/confs/cmp4-noc.conf -iInput/input.256 -ofmm.out -efmm.err fmm.mipseb -p 1
  rm ~/Repos/HPCA/PRJ2/trial1/sesc_fmm.mipseb.Default
  cp ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb.Default ~/Repos/HPCA/PRJ2/trial1/
  
  # copy over error files and print them out
  echo " ~~~~~~ ERRORS ~~~~~~"
  cp ~/sesc/apps/Splash2/fmm/fmm.err ~/Repos/HPCA/PRJ2/trial1/
  cat ~/sesc/apps/Splash2/fmm/fmm.err
  echo ""
  echo " ~~~~~~  OUT   ~~~~~~"
  cp ~/sesc/apps/Splash2/fmm/fmm.out ~/Repos/HPCA/PRJ2/trial1/
  cat ~/sesc/apps/Splash2/fmm/fmm.out
  echo " ~~~~~~~~~~~~~~~~~~~~"

  # get report statistics
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb.Default >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  
  # output results
  echo "~~~~~  HYBRID ~~~~~~" >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  
}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ2."
echo "by TeeJ"
echo ""
simulate
echo "~~~~ Finishing Main ~~~~"
