#!/usr/bin/bash
#PBS -l select=1:ncpus=8:mpiprocs=1:ompthreads=1
#PBS -q gpu
#PBS -j oe
source ~/.bashrc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wesley/anaconda3/lib/
cd /home/wesley/EDC/Coke/ML
echo "=========================================================="
echo "Starting on : $(date)"
echo "Running on node : $(hostname)"
echo "Current directory : $(pwd)"
echo "Current job ID : $PBS_JOBID"
echo "=========================================================="

START_TIME=$SECONDS

# NAME='0320_FPC_lowparam_norm'
# NAME='0322_FPC_lowparam_6_29'
# NAME='0323_FPC_model_no_model'
# NAME='0323_FPC_modelV2'
# NAME='0323_FPC_modelV2_allin'
# NAME='0404_FPC_modelV5'
# NAME='0405_FPC_modelV6'
# NAME='0323_FPC_modelV2_big'
# NAME='0405_FPC_modelV6_temprand'
NAME='0430_FPC_modelV6_area'
# NAME='0406_test'
# DATA='training_data_FPC_V1_3m_5p_6t_21Clppm.csv'
# DATA='training_data_cracking_V7_3m_choi_rev.csv'
# DATA='training_data_FPC_V4_3m_irrev.csv'
# DATA='training_data_FPC_V5_addprev.csv'
# DATA='training_data_FPC_V7_addprev_Temprand.csv'
DATA='training_data_FPC_V8_addprev_area.csv'
# DATA='training_data_FPC_V3_3m_5p_6t_21Cl_rev.csv'
# MODEL='ML_model_V2'
# MODEL='ML_model_V5'
MODEL='ML_model_V6'

# MODEL='ML_model_V2_allin'
# MODEL='ML_model_no_kinetic'

mkdir /home/wesley/EDC/FPC/ML/results/$NAME
python  -u -m $MODEL --no_gene --no_predict --name $NAME  --FPC --data $DATA |tee /home/wesley/EDC/Coke/ML/results/$NAME/$NAME.log
python  -u -m $MODEL --no_train    --name $NAME  --no_tubes   --FPC --data $DATA |tee /home/wesley/EDC/Coke/ML/results/$NAME/predict.log
# python  -u -m $MODEL --no_train --no_gene --name $NAME   --FPC  --data $DATA |tee /home/wesley/Coke/FPC/ML/results/$NAME/predict2.log

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "$(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec"
echo "Job Ended at $(date)"
echo '======================================================='

conda deactivate
