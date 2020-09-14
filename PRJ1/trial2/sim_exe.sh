function simlulation
{
  # clear results.txt
  echo "Simulation executing..." > results.txt
  echo "" >> results.txt

  # run simulation for hybrid case
  echo "~~~~~  HYBRID  ~~~~~" >> results.txt
  ~/sesc/sesc.opt -f HyA -c cmp4-noc.conf -ort.out -ert.err ~/sesc/apps/Splash2/raytrace/raytrace.mipseb -p1 -m128 -a3 ~/sesc/apps/Splash2/raytrace/Input/reduced.env
  mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.HyA .
  ~/sesc/scripts/report.pl sesc_raytrace.mipseb.HyA >> results.txt
  echo "~~~~~  HYBRID ~~~~~~" >> results.txt
}


#cd ~/sesc/apps/Splash2/raytrace
#~/sesc/sesc.opt -f HyA -c ~/sesc/confs/cmp4-noc.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
#mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.HyA ~/Repos/HPCA/PRJ1/trial2/
#~/sesc/sesc.opt -f OrA -c ~/sesc/confs/cmp4-noc-ora.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
#mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.OrA ~/Repos/HPCA/PRJ1/trial2/
#~/sesc/sesc.opt -f NTA -c ~/sesc/confs/cmp4-noc-nta.conf -ort.out -ert.err raytrace.mipseb -p1 -m128 -a3 Input/reduced.env
#mv ~/sesc/apps/Splash2/raytrace/sesc_raytrace.mipseb.NTA ~/Repos/HPCA/PRJ1/trial2/

echo "~~~~ Starting Simulation ~~~~"
echo "I will be simulating a processor with this script. PRJ1."
echo "by TeeJ"
echo ""
simulation
echo "~~~~ Finishing Main ~~~~"