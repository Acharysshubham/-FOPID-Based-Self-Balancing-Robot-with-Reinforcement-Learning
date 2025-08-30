%% 01 — Exploration 
clc; clear; close all;

model = 'RL_Model'; open_system(model)

% Observation/Action specs (adjust sizes to match your model)
obsInfo = rlNumericSpec([3 1], 'LowerLimit', [-inf -inf -inf]', 'UpperLimit', [inf inf inf]');
actInfo = rlNumericSpec([3 1]);  % For full FOPID, change to [5 1]

% Env
env = make_env(model, 'RL_Model/RL Agent', obsInfo, actInfo);
env.ResetFcn = @(in)localResetFcn(in);

% Peek Simulink structure
bdroot

%% Sanity sim (no training) — requires a random agent or fixed action source in model
disp('Environment ready. Proceed to the training notebook.')
