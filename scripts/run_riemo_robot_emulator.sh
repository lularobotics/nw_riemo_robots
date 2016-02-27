#!/bin/bash

# Executes RieMO robot emulator 

#Q_INIT_CSV="-0.614159,0,-0.400798,1.83805,-1.63068,1.42643,0.623563,0.623563"  # kinova-ros setup
Q_INIT_CSV="-1.14008,3.31725,2.9309,0.895853,1.66968,-2.87169,0.639584,0.638662"

JOINT_STATE_TOPIC=joint_states
JOINT_TRAJECTORY_TOPIC=joint_trajectory_raw

rosrun riemo_programs riemo_robot_emulator \
  --robot_package_name=nw_riemo_robots \
  --riemo_json_config=riemo_robot_mico_nw.json \
  --q_init_csv=$Q_INIT_CSV \
  --joint_state_topic=$JOINT_STATE_TOPIC \
  --joint_trajectory_topic=$JOINT_TRAJECTORY_TOPIC
