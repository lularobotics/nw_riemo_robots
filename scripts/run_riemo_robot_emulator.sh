# Executes RieMO robot emulator 

Q_INIT_CSV="0.790,0.054,-1.180,-1.012,1.755,-0.121,0.630,0.607"

################################################################################

RIEMO_ROBOT_TYPE=basic
ROBOT_PACKAGE_NAME=nw_riemo_robots
RIEMO_JSON_CONFIG=riemo_robot_mico.json

JOINT_STATE_TOPIC=joint_states

# Straightforward execution of the policy.
DILATION_FACTORS_CSV=.5
DILATION_TIMES_CSV=-1.
POLICY_EXECUTION_START_TIME=0.

rosrun riemo_programs riemo_robot_emulator \
  --q_init_csv=$Q_INIT_CSV \
  \
  --apollo_riemo_robot_type=$RIEMO_ROBOT_TYPE \
  --robot_package_name=$ROBOT_PACKAGE_NAME \
  --riemo_json_config=$RIEMO_JSON_CONFIG \
  --joint_state_topic=$JOINT_STATE_TOPIC \

