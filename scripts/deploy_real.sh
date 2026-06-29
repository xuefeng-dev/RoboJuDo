dataset_name=kimodo_walking_4motion
experiment_name=kimodo_walking_4motion_g1
motion_index=0
motion_height_offset=-0.02 # 参考动作高度偏移，负数表示降低高度


# dataset_name=amass_kung_fu_1motion
# motion_index=0
# experiment_name=kimodo_soma_walking_1motion_g1



# compiled_model_dir=results/amass_kung_fu_sample_g1_bm_tracker/compiled_models_score_based
# compiled_model_dir=results/amass_kung_fu_sample_g1_bm_tracker/compiled_models_last
compiled_model_dir=results/$experiment_name/compiled_models
onnx_file=$compiled_model_dir/unified_pipeline.onnx

motion_path=dataset/$dataset_name/motionlib/proto-g1.pt


# 1: 将参考动作第 0 帧作为准备和淡出的默认姿态；0: 使用环境默认站姿。
default_pose_from_motion_first_frame=1

if [ "$default_pose_from_motion_first_frame" = "1" ]; then
    default_pose_arg=--default-pose-from-motion-first-frame
else
    default_pose_arg=
fi

onnx_file=$(realpath "$onnx_file")
motion_path=$(realpath "$motion_path")
robojudo_python=/home/zxf/miniconda3/envs/robojudo/bin/python

cd /home/zxf/RoboJuDo

# 启动前打印当前 tracker 配置里实际启用的键盘控制说明。
cat <<'EOF'
Keyboard shortcuts for g1_protomotions_tracker:
  r   Start/restart motion from frame 0, or fade in from default pose
  <   Fade in: switch from default pose to motion tracking
  >   Fade out: switch back to default pose
  i   Reborn/reset the simulation environment
  9   Release the virtual gantry support
  o   Shutdown the environment

Note: shortcuts trigger when the key is released. Use Shift for < and >.
EOF

"$robojudo_python" scripts/run_tracker_pipeline.py -c g1_protomotions_tracker_real \
    --onnx-path "$onnx_file" \
    --motion-path "$motion_path" \
    --motion-index "$motion_index" \
    --motion-height-offset "$motion_height_offset" \
    $default_pose_arg