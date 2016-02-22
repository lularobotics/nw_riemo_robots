#!/bin/bash

# Executes RieMO robot emulator 

Q_INIT_CSV="-0.614159,0,-0.400798,1.83805,-1.63068,1.42643,0.623563,0.623563"

JOINT_STATE_TOPIC=joint_states

rosrun riemo_programs riemo_robot_emulator \
  --robot_package_name=nw_riemo_robots \
  --riemo_json_config=riemo_robot_mico.json \
  --q_init_csv=$Q_INIT_CSV \
  --joint_state_topic=$JOINT_STATE_TOPIC \

