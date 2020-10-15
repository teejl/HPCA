function init 
{
  # clear results_test.txt
  echo "Simulation executing..." > ~/Repos/HPCA/PRJ2/trial2/results_test.txt
  echo "" >> results_test.txt

  # resetting the configuration files
  rm ~/sesc/src/libsuc/CacheCore.cpp
  rm ~/sesc/src/libsuc/CacheCore.h
  rm ~/sesc/src/libcmp/SMPCache.cpp
  rm ~/sesc/src/libcmp/SMPCache.h
  cp ~/Repos/HPCA/PRJ2/trial2/CacheCore.cpp ~/sesc/src/libsuc/
  cp ~/Repos/HPCA/PRJ2/trial2/CacheCore.h ~/sesc/src/libsuc/
  cp ~/Repos/HPCA/PRJ2/trial2/SMPCache.cpp ~/sesc/src/libcmp/
  cp ~/Repos/HPCA/PRJ2/trial2/SMPCache.h ~/sesc/src/libcmp/

  # build out simulator and simulation
  cd ~/sesc/
  make
  cd ~/sesc/apps/Splash2/lu
  make
}

function simulate
{
  # run simulation for default case
  echo "~~~~~  ${2}  ~~~~~" >> ~/Repos/HPCA/PRJ2/trial2/results_test.txt

  # remove output, run simulation, and copy it to the trail folder
  rm ~/sesc/apps/Splash2/lu/"sesc_lu.mipseb.${2}"
  cp ~/Repos/HPCA/PRJ2/trial2/"${1}" ~/sesc/confs/
  ~/sesc/sesc.opt -f $2 -c ~/sesc/confs/"${1}" -iInput/input.256 -olu.out -elu.err lu.mipseb -n32 -p1
  rm ~/Repos/HPCA/PRJ2/trial2/"sesc_lu.mipseb.${2}"
  cp ~/sesc/apps/Splash2/lu/"sesc_lu.mipseb.${2}" ~/Repos/HPCA/PRJ2/trial2/
  
  # copy over error files and print them out
  echo " ~~~~~~ ERRORS ~~~~~~"
  cp ~/sesc/apps/Splash2/lu/lu.err ~/Repos/HPCA/PRJ2/trial2/
  cat ~/sesc/apps/Splash2/lu/lu.err
  echo ""
  echo " ~~~~~~  OUT   ~~~~~~"
  cp ~/sesc/apps/Splash2/lu/lu.out ~/Repos/HPCA/PRJ2/trial2/
  cat ~/sesc/apps/Splash2/lu/lu.out
  echo " ~~~~~~~~~~~~~~~~~~~~"

  # get report statistics
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/lu/"sesc_lu.mipseb.${2}" >> ~/Repos/HPCA/PRJ2/trial2/results_test.txt
  
  # output results
  echo "~~~~~  ${2}  ~~~~~"  >> ~/Repos/HPCA/PRJ2/trial2/results_test.txt
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
simulate cmp4-noc.conf Default
simulate cmp4-noc-L1NXLRU.conf L1NXLRU
#simulate cmp4-noc-dmap-l1.conf DMapL1
#simulate cmp4-noc-5cyc-l1.conf 5CycL1
#simulate cmp4-noc-9cyc-l1.conf 9CycL1
echo "~~~~ Finishing Simulation ~~~~"
