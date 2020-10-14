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
  echo "~~~~~  ${2}  ~~~~~" >> ~/Repos/HPCA/PRJ2/trial1/results.txt

  # remove output, run simulation, and copy it to the trail folder
  rm ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb."${2}"
  ~/sesc/sesc.opt -f Default -c ~/Repos/HPCA/PRJ2/trial1/"${1}" -iInput/input.256 -ofmm.out -efmm.err fmm.mipseb -p 1
  rm ~/Repos/HPCA/PRJ2/trial1/sesc_fmm.mipseb."${2}"
  cp ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb."${2}" ~/Repos/HPCA/PRJ2/trial1/
  
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
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/fmm/sesc_fmm.mipseb."${2}" >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  
  # output results
  echo "~~~~~  ${2}  ~~~~~"  >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  echo ""

}

function testing
{
    echo "${1}"
    echo $2
}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ2."
echo "by TeeJ"
#testing cmp4-noc.conf Default
init
simulate "cmp4-noc.conf" Default
#simulate cmp4-noc-small-l1.conf SmallL1
#simulate cmp4-noc-dmap.conf DMapL1
#simulate cmp4-noc-5cyc-l1.conf 5CycL1
#simulate cmp4-noc-9cyc-l1.conf 9CycL1
echo "~~~~ Finishing Simulation ~~~~"
