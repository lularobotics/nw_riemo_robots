#!/bin/bash

# Executes RieMO robot emulator 

# [0] bounds: [-3.6652, 0.5236]
# [1] bounds: [2.46, 5.26]
# [2] bounds: [0.65, 4.01]
# [3] bounds: [-6.28319, 6.28319]
# [4] bounds: [-6.28319, 6.28319]
# [5] bounds: [-6.28319, 6.28319]
# [6] bounds: [0, 0.8]
# [7] bounds: [0, 0.8]

#Q_INIT_CSV="-0.614159,0,-0.400798,1.83805,-1.63068,1.42643,0.623563,0.623563"  # kinova-ros setup
#Q_INIT_CSV="-1.14008,3.31725,2.9309,0.895853,1.66968,-2.87169,0.639584,0.638662" # Orig NW urdf qinit
Q_INIT_CSV="2.0590,-0.1663,0.2239,-2.1501,1.6512,0.2339,0.69,0.69" # Modified to fit NW's setup

JOINT_STATE_TOPIC=joint_states
JOINT_TRAJECTORY_TOPIC=joint_trajectory_raw

rosrun riemo_programs riemo_robot_emulator \
  --robot_package_name=nw_riemo_robots \
  --riemo_json_config=riemo_robot_mico_nw.json \
  --q_init_csv=$Q_INIT_CSV \
  --joint_state_topic=$JOINT_STATE_TOPIC \
  --joint_trajectory_topic=$JOINT_TRAJECTORY_TOPIC
