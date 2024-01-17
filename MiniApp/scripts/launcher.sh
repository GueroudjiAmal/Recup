ml load gcc/12.2.0 PrgEnv-gnu cudatoolkit-standalone libfabric/1.15.2.0 cray-mpich/8.1.25
source  ~/spack/share/spack/setup-env.sh
spack env activate Recup

DIR=$PWD
echo $DIR

RUNS=100
NWORKERS=4

for R in 1  #{1..$RUNS}
do
    NNODES=$(($NWORKER /2 + 2)) #2 workers per node, one node for client and one for scheduler
    mkdir -p RECUP
    DATE=$(date +"%Y-%m-%d_%T")
    WORKSPACE=$DIR/RECUP/D${DATE}_W${NWORKER}/
    mkdir  -p $WORKSPACE
    cd $WORKSPACE
    cp -r  $DIR/*.py  $DIR/scripts/* $DIR/*.txt  .
    echo Running in $WORKSPACE 
    export DARSHAN_LOG_DIR_PATH=$WORKSPACE
    qsub -A radix-io -l select=$NNODES:system=polaris -o $WORKSPACE Script_Polaris.sh
done

