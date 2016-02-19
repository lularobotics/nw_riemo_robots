# Executes RieMO robot emulator 

Q_INIT_CSV="0.790,0.054,-1.180,-1.012,1.755,-0.121,0.630,0.607"

JOINT_STATE_TOPIC=joint_states

rosrun riemo_programs riemo_robot_emulator \
  --q_init_csv=$Q_INIT_CSV \
  --joint_state_topic=$JOINT_STATE_TOPIC \

