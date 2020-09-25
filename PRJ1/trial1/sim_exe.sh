function simulate
{
  # clear results.txt
  echo "Simulation executing..." > ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> results.txt

  # run simulation for hybrid case
  echo "~~~~~  HYBRID  ~~~~~" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  # reusable try start
  #~/sesc/sesc.opt -f HyA -c cmp4-noc.conf -ort.out -ert.err ~/sesc/apps/Splash2/raytrace/raytrace.mipseb -p1 -m128 -a3 ~/sesc/apps/Splash2/raytrace/Input/reduced.env
  #mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.HyA .
  #~/sesc/scripts/report.pl sesc_raytrace.mipseb.HyA >> results.txt
  # end

  cd ~/sesc/apps/Splash2/raytrace
  cp ~/Repos/HPCA/PRJ1/trial1/cmp4-noc.conf ~/sesc/confs/cmp4-noc.conf
  rm ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.HyA
  ~/sesc/sesc.opt -f HyA -c ~/sesc/confs/cmp4-noc.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
  rm ~/Repos/HPCA/PRJ1/trial1/sesc_raytrace.mipseb.HyA
  cp ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.HyA ~/Repos/HPCA/PRJ1/trial1/
  ~/sesc/scripts/report.pl ~/Repos/HPCA/PRJ1/trial1/sesc_raytrace.mipseb.HyA >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "~~~~~  HYBRID ~~~~~~" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial1/results.txt

  # run simulation for oracle case
  echo "~~~~~  ORACLE  ~~~~~" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  cd ~/sesc/apps/Splash2/raytrace
  cp ~/Repos/HPCA/PRJ1/trial1/cmp4-noc-ora.conf ~/sesc/confs/cmp4-noc-ora.conf
  rm ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.OrA
  ~/sesc/sesc.opt -f OrA -c ~/sesc/confs/cmp4-noc-ora.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
  rm ~/Repos/HPCA/PRJ1/trial1/sesc_raytrace.mipseb.OrA
  cp ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.OrA ~/Repos/HPCA/PRJ1/trial1/
  ~/sesc/scripts/report.pl ~/Repos/HPCA/PRJ1/trial1/sesc_raytrace.mipseb.OrA >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "~~~~~  ORACLE ~~~~~~" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial1/results.txt

  # run simulation for oracle case
  echo "~~~~~  NOT TAKEN  ~~~~~" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  cd ~/sesc/apps/Splash2/raytrace
  cp ~/Repos/HPCA/PRJ1/trial1/cmp4-noc-nta.conf ~/sesc/confs/cmp4-noc-nta.conf
  rm ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.NTA
  ~/sesc/sesc.opt -f NTA -c ~/sesc/confs/cmp4-noc-nta.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
  rm ~/Repos/HPCA/PRJ1/trial1/sesc_raytrace.mipseb.NTA
  cp ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.NTA ~/Repos/HPCA/PRJ1/trial1/
  ~/sesc/scripts/report.pl ~/Repos/HPCA/PRJ1/trial1/sesc_raytrace.mipseb.NTA >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "~~~~~  NOT TAKEN ~~~~~~" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
  echo "" >> ~/Repos/HPCA/PRJ1/trial1/results.txt
}


#cd ~/sesc/apps/Splash2/raytrace
#~/sesc/sesc.opt -f HyA -c ~/sesc/confs/cmp4-noc.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
#mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.HyA ~/Repos/HPCA/PRJ1/trial1/
#~/sesc/sesc.opt -f OrA -c ~/sesc/confs/cmp4-noc-ora.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
#mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.OrA ~/Repos/HPCA/PRJ1/trial1/
#~/sesc/sesc.opt -f NTA -c ~/sesc/confs/cmp4-noc-nta.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
#mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.NTA ~/Repos/HPCA/PRJ1/trial1/

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ1."
echo "by TeeJ"
echo ""
simulate
echo "~~~~ Finishing Main ~~~~"
