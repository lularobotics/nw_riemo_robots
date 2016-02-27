#!/bin/bash
# Executes an LQR problem.

JOINT_STATE_TOPIC=joint_states
JOINT_TRAJECTORY_TOPIC=joint_trajectory

rosrun riemo_programs riemo_move_basic_server \
  --joint_state_topic=$JOINT_STATE_TOPIC \
  --joint_trajectory_topic=$JOINT_TRAJECTORY_TOPIC \
  --sphere_obstacle_frame_id="base_link"
