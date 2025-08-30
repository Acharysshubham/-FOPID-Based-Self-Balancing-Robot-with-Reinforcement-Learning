function env = make_env(modelName, agentPath, obsInfo, actInfo)
%MAKE_ENV Build rlSimulinkEnv with given specs
% modelName: 'RL_Model', agentPath: 'RL_Model/RL Agent'
env = rlSimulinkEnv(modelName, agentPath, obsInfo, actInfo);
end
