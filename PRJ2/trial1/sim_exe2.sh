function init 
{
  # clear results.txt
  echo "Simulation executing..." > ~/Repos/HPCA/PRJ2/trial1/results.txt
  echo "" >> results.txt

  # resetting the configuration files
  rm ~/sesc/src/libcore/BPred.cpp
  rm ~/sesc/src/libcore/BPred.h
  #rm ~/sesc/confs/cmp4-noc.conf
  cp ~/Repos/HPCA/PRJ2/SESC_original_files/BPred.cpp ~/sesc/src/libcore/BPred.cpp
  cp ~/Repos/HPCA/PRJ2/SESC_original_files/BPred.h ~/sesc/src/libcore/BPred.h
  #cp ~/Repos/HPCA/PRJ2/SESC_original_files/cmp4-noc.conf ~/sesc/confs/cmp4-noc.conf

  # build out simulator and simulation
  cd ~/sesc/
  make
  cd ~/sesc/apps/Splash2/fmm
  make
}

function simulate
{
  # run simulation for default case
  echo "~~~~~  DEFAULT  ~~~~~" >> ~/Repos/HPCA/PRJ2/trial1/results.txt

  # remove output, run simulation, and copy it to the trail folder
  rm ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb.$2
  ~/sesc/sesc.opt -f $2 -c ~/Repos/HPCA/PRJ2/trial1/$1 -iInput/input.256 -ofmm.out -efmm.err fmm.mipseb -p 1
  rm ~/Repos/HPCA/PRJ2/trial1/sesc_fmm.mipseb.$2
  cp ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb.$2 ~/Repos/HPCA/PRJ2/trial1/
  
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
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb.$2 >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  
  # output results
  echo "~~~~~  DEFAULT  ~~~~~"  >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  echo ""

}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ2."
echo "by TeeJ"
echo ""
init
simulate "cmp4-noc.conf" "Default"
echo "~~~~ Finishing Simulation ~~~~"
