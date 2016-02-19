# Executes RieMO robot emulator 

################################################################################

RIEMO_ROBOT_TYPE=basic
ROBOT_PACKAGE_NAME=nw_riemo_robots
RIEMO_JSON_CONFIG=riemo_robot_mico.json

JOINT_STATE_TOPIC=joint_states

rosrun riemo_programs riemo_robot_visualizer \
  --apollo_riemo_robot_type=$RIEMO_ROBOT_TYPE \
  --robot_package_name=$ROBOT_PACKAGE_NAME \
  --riemo_json_config=$RIEMO_JSON_CONFIG \
  --joint_state_topic=$JOINT_STATE_TOPIC \

