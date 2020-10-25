function init 
{
  # set the current directory
  cwd="$PWD"

  # clear results.txt
  echo "Simulation executing..." > "$cwd"/results.txt
  echo "" >> results.txt

  # resetting the configuration files
  rm ~/sesc/src/libsuc/CacheCore.cpp
  rm ~/sesc/src/libsuc/CacheCore.h
  rm ~/sesc/src/libcmp/SMPCache.cpp
  rm ~/sesc/src/libcmp/SMPCache.h
  cp "$cwd"/CacheCore.cpp ~/sesc/src/libsuc/
  cp "$cwd"/CacheCore.h ~/sesc/src/libsuc/
  cp "$cwd"/SMPCache.cpp ~/sesc/src/libcmp/
  cp "$cwd"/SMPCache.h ~/sesc/src/libcmp/

  # build out simulator and simulation
  cd ~/sesc/
  make
  cd ~/sesc/apps/Splash2/lu
  make
}

function simulate
{
  # run simulation for default case
  echo "~~~~~  ${2}  ~~~~~" >> "$cwd"/results.txt

  # remove output, run simulation, and copy it to the trail folder
  rm ~/sesc/apps/Splash2/lu/"sesc_lu.mipseb.${2}"
  cp "$cwd"/"${1}" ~/sesc/confs/
  ~/sesc/sesc.opt -f"$2" -c ~/sesc/confs/"${1}" -olu.out -elu.err lu.mipseb -n256 –p"$3"
  rm "$cwd"/"sesc_lu.mipseb.${2}"
  cp ~/sesc/apps/Splash2/lu/"sesc_lu.mipseb.${2}" "$cwd"/

  #~/sesc/sesc.opt -fAp1 -c ~/sesc/confs/cmp16-noc.conf -olu.out -elu.err lu.mipseb -n256 -p1
  #~/sesc/sesc.opt -fAp2 -c ~/sesc/confs/cmp16-noc.conf -olu.out -elu.err lu.mipseb -n256 -p2
  #~/sesc/sesc.opt -fAp4 -c ~/sesc/confs/cmp16-noc.conf -olu.out -elu.err lu.mipseb -n256 -p4
  
  # copy over error files and print them out
  echo " ~~~~~~ ERRORS ~~~~~~"
  cp ~/sesc/apps/Splash2/lu/lu.err "$cwd"/
  cat ~/sesc/apps/Splash2/lu/lu.err
  echo ""
  echo " ~~~~~~  OUT   ~~~~~~"
  cp ~/sesc/apps/Splash2/lu/lu.out "$cwd"/
  cat ~/sesc/apps/Splash2/lu/lu.out
  echo " ~~~~~~~~~~~~~~~~~~~~"

  # get report statistics
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/lu/"sesc_lu.mipseb.${2}" >> "$cwd"/results.txt
  
  # output results
  echo "~~~~~  ${2}  ~~~~~"  >> "$cwd"/results.txt
  echo ""

}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ3."
echo "by TeeJ"
init # initialize files for running simulation
simulate cmp16-noc.conf Ap1 1 # simulate for Ap1
simulate cmp16-noc.conf Ap4 4 # simulate for Ap4
simulate cmp16-noc.conf Ap16 16 # simulate for Ap16
echo "~~~~ Finishing Simulation ~~~~"
