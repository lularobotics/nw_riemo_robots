# Executes an LQR problem.

################################################################################
#-------------------------------------------------------------------------------
# Problem specification constraint parameters
# 1. USE_UPRIGHT_ORIENTATION_CONSTRAINT: Keep end effector upright throughout
#    motion 
# 2. USE_UPRIGHT_ORIENTATION_CONSTRAINT_END_ONLY: Keep end-effector upright
#    only at final config
# 3. APPROACH_CONSTRAINT_CSV: When set, constraints final configuration to have
#    end-effector z-axis pointed in this direction.
# 4. SPHERE_OBSTACLE_CONSTRAINT_CSV: When set, adds a sphereical obstacle
#    constraint.  Format: 'x,y,z,radius'
# 5. PASSTHROUGH_CONSTRAINT_CSV: When set, adds a constraint specifying a box
#    that the robot should pass through. Format: 'x,y,z,radius,t_fraction'. The
#    constraint is added at t = t_fraction * T. Give the user control over how
#    the robot moves around the object. This version is more restrictive than
#    OBSTACLE_LINEARIZATION_CONSTRAINT_CSV, which just specifies whether the end-
#    effector should pass above or below a plane.
# 6. OBSTACLE_LINEARIZATION_CONSTRAINT_CSV: When set, adds a constraint specifying 
#    a linearization of the obstacle constraint at a pointon the surface. the 
#    constraint will be applied at a single configuration somewhere along the 
#    trajectory (user specified). Format: 'x,y,z,t_fraction'. (x,y,z) specifies
#    a point in 3-space. The point on the surface is deduced as the point where 
#    the ray from the sphere's center to the specified point intersects the surface.
#    The resulting constraint is a linear constraint, with zero value at that 
#    point, increasing positively in the direction of the ray. (The zero set of the 
#    linearization is a tangent plane to the sphere.) t_fraction specifies where 
#    along the trajectory the constraint will be applied as t = T * t_fraction.
#    Usually, t_fraction = .5 (half way through the trajectory) is good. Gives
#    the user control over how the robot moves around the object. This version
#    is less restrictive than PASSTHROUGH_CONSTRAINT_CSV, which specifies a 
#    box in 3-space through which the robot's end-effector should pass.
#-------------------------------------------------------------------------------


JOINT_STATE_TOPIC=joint_states
JOINT_TRAJECTORY_TOPIC=joint_trajectory

USE_UPRIGHT_ORIENTATION_CONSTRAINT=true
USE_UPRIGHT_ORIENTATION_CONSTRAINT_END_ONLY=false
APPROACH_CONSTRAINT_CSV=.5,1.,0.

SPHERE_OBSTACLE_CONSTRAINT_CSV=0.0,0.5,0.1,0.15
OBSTACLE_LINEARIZATION_CONSTRAINT_CSV=0.0,0.0,0.1,0.5
#PASSTHROUGH_CONSTRAINT_CSV=0.0,0.35,0.1,0.05,0.5

################################################################################

RIEMO_ROBOT_TYPE=basic
ROBOT_PACKAGE_NAME=nw_riemo_robots
RIEMO_JSON_CONFIG=riemo_robot_mico.json

CONTROL_DT=.01
ACTION_GAIN=5.
INTERMEDIATE_POSITION_GAINS_CSV="10000, 100"
INTERMEDIATE_VELOCITY_GAINS_CSV="10000, 100"
TERMINAL_POSITION_GAINS_CSV="10000, 100"
TERMINAL_VELOCITY_GAINS_CSV="10000, 100"

CSPACE_VEL_SCALAR=30.
CSPACE_ACC_SCALAR=30.
CSPACE_INIT_VEL_SCALAR=10.
CSPACE_INIT_ACC_SCALAR=10.
TASK_VEL_SCALAR=10.
TASK_ACC_SCALAR=1000.
VERTICAL_POTENTIAL_SCALAR=0.
BASE_HEURISTIC_POTENTIAL_SCALAR=0.

COST_GRADIENT_METRIC_SCALAR=5000  # Use for spherical metric
COST_GRADIENT_METRIC_ALPHA=.9

JOINT_POTENTIAL_SCALAR=2.
POSTURE_SCALAR=2.
TERMINAL_TERM_SCALAR=100000.
TERMINAL_TASK_VELOCITY_TERM_SCALAR=2000.
INITIAL_TASK_VELOCITY_TERM_SCALAR=500.

NEWTON_OPTIMIZER_TYPE=newton_adaptive_step_size
OUTER_LOOP_ITERS=25
INNER_LOOP_ITERS=20
OPTIMIZER_FLAGS="\
  --maximum_outer_loop_iters=$OUTER_LOOP_ITERS \
  --inner_loop_optimizer_type="$NEWTON_OPTIMIZER_TYPE" \
  --maximum_inner_loop_iters=$INNER_LOOP_ITERS \
  --gradient_norm_threshold=.01 \
  --init_ss=.5 \
  --lambda=.001 \
  --mu=10 \
  --max_abs_lagrange_multiplier=1000 \
  --x_convergence_epsilon=.01 \
  \
  --trust_region_increase_factor=10 \
  --trust_region_decrease_factor=.5 \
"

# Exercise lots of intermediate time dilations and skipping a prefix portion of
# the policy.
#DILATION_FACTORS_CSV=1.,.5,2.,1.
#DILATION_TIMES_CSV=.5,.75,3.,-1.
#DILATION_FACTORS_CSV=1.,2.,.5
#DILATION_TIMES_CSV=1.,2.,-1.
#POLICY_EXECUTION_START_TIME=1.

# Straightforward execution of the policy.
DILATION_FACTORS_CSV=.5
DILATION_TIMES_CSV=-1.
POLICY_EXECUTION_START_TIME=0.

rosrun riemo_programs riemo_move_basic_server \
  --joint_state_topic=$JOINT_STATE_TOPIC \
  --joint_trajectory_topic=$JOINT_TRAJECTORY_TOPIC \
  \
  --verbose=true \
  --use_upright_orientation_constraint=$USE_UPRIGHT_ORIENTATION_CONSTRAINT \
  --use_upright_orientation_constraint_end_only=$USE_UPRIGHT_ORIENTATION_CONSTRAINT_END_ONLY \
  --approach_constraint_csv=$APPROACH_CONSTRAINT_CSV \
  --sphere_obstacle_constraint_csv=$SPHERE_OBSTACLE_CONSTRAINT_CSV \
  --passthrough_constraint_csv=$PASSTHROUGH_CONSTRAINT_CSV \
  --obstacle_linearization_constraint_csv=$OBSTACLE_LINEARIZATION_CONSTRAINT_CSV \
  --include_floor_constraint=true \
  \
  --T=30 \
  --dt=.2 \
  --dilation_factors_csv=$DILATION_FACTORS_CSV \
  --dilation_times_csv=$DILATION_TIMES_CSV \
  --policy_execution_start_time=$POLICY_EXECUTION_START_TIME \
  --apollo_riemo_robot_type=$RIEMO_ROBOT_TYPE \
  --robot_package_name=$ROBOT_PACKAGE_NAME \
  --riemo_json_config=$RIEMO_JSON_CONFIG \
  \
  $OPTIMIZER_FLAGS \
  \
  --cspace_vel_scalar=$CSPACE_VEL_SCALAR \
  --cspace_acc_scalar=$CSPACE_ACC_SCALAR \
  --cspace_init_vel_scalar=$CSPACE_INIT_VEL_SCALAR \
  --cspace_init_acc_scalar=$CSPACE_INIT_ACC_SCALAR \
  --task_vel_scalar=$TASK_VEL_SCALAR \
  --task_acc_scalar=$TASK_ACC_SCALAR \
  --joint_potential_scalar=$JOINT_POTENTIAL_SCALAR \
  --posture_scalar=$POSTURE_SCALAR \
  --terminal_term_scalar=$TERMINAL_TERM_SCALAR \
  --initial_task_velocity_term_scalar=$INITIAL_TASK_VELOCITY_TERM_SCALAR \
  --terminal_task_velocity_term_scalar=$TERMINAL_TASK_VELOCITY_TERM_SCALAR \
  --vertical_potential_scalar=$VERTICAL_POTENTIAL_SCALAR \
  --base_heuristic_potential_scalar=$BASE_HEURISTIC_POTENTIAL_SCALAR \
  --cost_gradient_metric_scalar=$COST_GRADIENT_METRIC_SCALAR \
  --cost_gradient_metric_alpha=$COST_GRADIENT_METRIC_ALPHA \
  \
  --control_dt=$CONTROL_DT \
  --action_gain=$ACTION_GAIN \
  --intermediate_position_gains_csv="$INTERMEDIATE_POSITION_GAINS_CSV" \
  --intermediate_velocity_gains_csv="$INTERMEDIATE_VELOCITY_GAINS_CSV" \
  --terminal_position_gains_csv="$TERMINAL_POSITION_GAINS_CSV" \
  --terminal_velocity_gains_csv="$TERMINAL_VELOCITY_GAINS_CSV" \

