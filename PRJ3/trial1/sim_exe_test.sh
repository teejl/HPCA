function init 
{
  # set the current directory
  cwd="$PWD"

  # clear results_test.txt
  echo "Simulation executing..." > "$cwd"/results_test.txt
  echo "" >> results_test.txt

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
  cd ~/sesc/apps/Splash2/fft
  make
}

function simulate
{
  # run simulation for default case
  echo "~~~~~  ${2}  ~~~~~" >> "$cwd"/results_test.txt

  # remove output, run simulation, and copy it to the trail folder
  rm ~/sesc/apps/Splash2/fft/"sesc_fft.mipseb.${2}"
  cp "$cwd"/"${1}" ~/sesc/confs/
  ~/sesc/sesc.opt -f"$2" -c ~/sesc/confs/"${1}" -offt.out -efft.err fft.mipseb -p"$3"
  rm "$cwd"/"sesc_fft.mipseb.${2}"
  cp ~/sesc/apps/Splash2/fft/"sesc_fft.mipseb.${2}" "$cwd"/

  #~/sesc/sesc.opt -fAp1 -c ~/sesc/confs/cmp16-noc.conf -olu.out -elu.err lu.mipseb -n256 -p1
  #~/sesc/sesc.opt -fAp2 -c ~/sesc/confs/cmp16-noc.conf -olu.out -elu.err lu.mipseb -n256 -p2
  #~/sesc/sesc.opt -fAp4 -c ~/sesc/confs/cmp16-noc.conf -olu.out -elu.err lu.mipseb -n256 -p4
  
  # copy over error files and print them out
  echo " ~~~~~~ ERRORS ~~~~~~"
  cp ~/sesc/apps/Splash2/fft/fft.err "$cwd"/
  cat ~/sesc/apps/Splash2/fft/fft.err
  echo ""
  echo " ~~~~~~  OUT   ~~~~~~"
  cp ~/sesc/apps/Splash2/fft/fft.out "$cwd"/
  cat ~/sesc/apps/Splash2/fft/fft.out
  echo " ~~~~~~~~~~~~~~~~~~~~"

  # get report statistics
  ~/sesc/scripts/report.pl ~/sesc/apps/Splash2/fft/"sesc_fft.mipseb.${2}" >> "$cwd"/results_test.txt
  echo "" >> "$cwd"/results_test.txt
  
  # output results
  echo "~~~~~  ${2}  ~~~~~"  >> "$cwd"/results_test.txt
  echo ""

}

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ3."
echo "by TeeJ"
init # initialize files for running simulation
simulate cmp16-noc.conf Hp1 1
simulate cmp16-noc.conf Hp4 4
simulate cmp16-noc.conf Hp16 16
echo "~~~~ Finishing Simulation ~~~~"
