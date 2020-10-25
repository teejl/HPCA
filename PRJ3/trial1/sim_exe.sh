function init 
{
  # clear results.txt
  echo "Simulation executing..." > ~/Repos/HPCA/PRJ2/trial1/results.txt
  echo "" >> results.txt

  # resetting the configuration files
  rm ~/sesc/src/libsuc/CacheCore.cpp
  rm ~/sesc/src/libsuc/CacheCore.h
  rm ~/sesc/src/libcmp/SMPCache.cpp
  rm ~/sesc/src/libcmp/SMPCache.h
  cp ~/Repos/HPCA/PRJ2/trial1/CacheCore.cpp ~/sesc/src/libsuc/
  cp ~/Repos/HPCA/PRJ2/trial1/CacheCore.h ~/sesc/src/libsuc/
  cp ~/Repos/HPCA/PRJ2/trial1/SMPCache.cpp ~/sesc/src/libcmp/
  cp ~/Repos/HPCA/PRJ2/trial1/SMPCache.h ~/sesc/src/libcmp/

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
  rm ~/sesc/apps/Splash2/fmm/"sesc_fmm.mipseb.${2}"
  cp ~/Repos/HPCA/PRJ2/trial1/"${1}" ~/sesc/confs/
  ~/sesc/sesc.opt -f $2 -c ~/sesc/confs/"${1}" -iInput/input.256 -ofmm.out -efmm.err fmm.mipseb -p 1
  rm ~/Repos/HPCA/PRJ2/trial1/"sesc_fmm.mipseb.${2}"
  cp ~/sesc/apps/Splash2/fmm/"sesc_fmm.mipseb.${2}" ~/Repos/HPCA/PRJ2/trial1/
  
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
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/fmm/"sesc_fmm.mipseb.${2}" >> ~/Repos/HPCA/PRJ2/trial1/results.txt
  
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
simulate cmp-noc.conf Ap1
simulate cmp4-noc.conf Ap4
simulate cmp16-noc.conf Ap16
echo "~~~~ Finishing Simulation ~~~~"
