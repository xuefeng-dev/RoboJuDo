# 空翻等动作
motion_path=/home/zxf/dev/nvlabs/ProtoMotions/dataset/amass_kung_fu_sample/motionlib/proto-g1.pt
# 0: Male2MartialArtsKicks..., 1: 85_85_06..., 2: Male2MartialArtsExtended..., 3: 87_87_01...
# 修改前请确认是否有危险动作
# motion_index=0 # 大幅度旋转踢腿
motion_index=1 # 前空翻
# motion_index=2 # 一边挥拳，一边左移，最后会向前踢腿
# motion_index=3 # 空中大幅度转身

# 大步后退
# motion_path=assets/motions/g1/g1_bones_seed_mini.pt
# motion_index=0

robojudo_python=/home/zxf/miniconda3/envs/robojudo/bin/python

motion_path=$(realpath "$motion_path")

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

"$robojudo_python" scripts/run_tracker_pipeline.py -c g1_protomotions_tracker \
  --motion-path "$motion_path" \
  --motion-index "$motion_index"



