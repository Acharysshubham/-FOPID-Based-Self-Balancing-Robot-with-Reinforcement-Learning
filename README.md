# -FOPID-Based-Self-Balancing-Robot-with-Reinforcement-Learning


This repo trains a DDPG agent (MATLAB Reinforcement Learning Toolbox) to tune a **FOPID** controller inside a Simulink model (`RL_Model.slx`) for a self-balancing robot (inverted-pendulum-like). The agent observes robot state and outputs continuous actions mapped to controller gains (Kp, Ki, Kd). (If your model includes fractional orders λ, μ, extend the action space accordingly—notes below.)

## Problem
Balancing is sensitive to dynamics and disturbances; fixed PID gains underperform across operating ranges. We want an **adaptive FOPID** tuned by RL to keep pitch near a desired setpoint and reject disturbances.

## Approach
- **Environment**: Simulink model `RL_Model.slx` with block `RL_Model/RL Agent`.
- **Observations (3×1)**: e.g., [pitch, pitch_rate, motor_cmd] (per your model).
- **Actions (3×1)**: agent proposes controller gains [Kp, Ki, Kd] (bounded/normalized in model).
- **Agent**: DDPG with 500-unit FC networks for actor/critic; OU noise with decay.
- **Reset**: randomized desired pitch each episode.
- **Reward**: defined in Simulink (e.g., −|pitch_error| − α·energy − β·overshoot).

## Results (placeholders to be filled with your runs)
- Average reward converged to ~**> 998** over last 5 episodes (training stop criterion).
- Settling time ↓, overshoot ↓, steady-state error ≈ 0.
- Controller adapts to random setpoints in [−1.5, 0] rad (as scripted here).

## Impact
- Robust balance under varying references/disturbances.
- Less manual tuning; policy generalizes within trained envelope.
- Extensible to (Kp, Ki, Kd, **λ, μ**) for full FOPID.

## Files
- `/src` – modular MATLAB code (train, validate, networks, env, utils).
- `/notebooks` – Live-Script–style `.m` files for interactive runs.
- `/data` – sample log + schema.
- `requirements.txt` – MATLAB toolboxes & optional Python libs.

## How to Run
1. Open MATLAB R2023b+ with **Simulink** & **Reinforcement Learning Toolbox**.
2. Ensure `RL_Model.slx` is on the MATLAB path and has an RL Agent block at `RL_Model/RL Agent`.
3. In MATLAB:
   ```matlab
   addpath(genpath('src')); addpath('notebooks'); addpath('data');
   % Train
   [agent, trainingStats] = train_agent('RL_Model');
   % Validate
   results = validate_agent(agent, 'RL_Model');
