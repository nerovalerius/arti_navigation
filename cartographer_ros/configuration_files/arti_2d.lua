-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "os1_imu",
  published_frame = "odom",                 -- Needs to be odom, not base_link
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  use_odometry = true,                      -- SLAM completely fails without odometry data
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 0,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true

-- Use the IMU data from Ouster - does not seem to work properly - it is optional for 2D anyway
TRAJECTORY_BUILDER_2D.use_imu_data = false
TRAJECTORY_BUILDER_2D.imu_gravity_time_constant = .1

TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.15
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(35.)

-- Bandpass for 3D Point Clouds - Distance in meters
-- Localization fails of the range is too small, e.g from 0.5 to 1
TRAJECTORY_BUILDER_2D.min_range = 0.4
TRAJECTORY_BUILDER_2D.max_range = 4


POSE_GRAPH.optimization_problem.huber_scale = 1e2

-- turn off global SLAM to not mess with tuning of local SLAM = 0
-- POSE_GRAPH.optimize_every_n_nodes = 1

-- voxel size -- original value: 0.025
-- value 0.5 is too high - result gets blurred
TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.025

-- size of submaps
TRAJECTORY_BUILDER_2D.submaps.num_range_data = 1000                                       -- IMPORTANT!!!

-- Number of 3D Images for a single scan -- 1 or let it be - does not help
-- TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 1

--TRAJECTORY_BUILDER_2D.imu_gravity_time_constant = .1

-- Costs for moving the result away from the prior 
-- scan matching has to generate a higher score in another position to be accepted
-- translation values: 1e3 = really expensive
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 3                           -- IMPORTANT!!!
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 3                              -- IMPORTANT!!!

-- individual weights of local SLAM and odometry
POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 3                   -- IMPORTANT!!!
POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 3                      -- IMPORTANT!!!
POSE_GRAPH.optimization_problem.odometry_translation_weight = 3                          -- IMPORTANT!!!
POSE_GRAPH.optimization_problem.odometry_rotation_weight = 3                             -- IMPORTANT!!!

-- Set Threads to 4 
MAP_BUILDER.num_background_threads = 4

-- T



return options