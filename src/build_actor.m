function actor = build_actor(obsInfo, actInfo)
%BUILD_ACTOR Actor network (DDPG)

numObs = obsInfo.Dimension(1);
numAct = actInfo.Dimension(1);

actorNet = [
    imageInputLayer([numObs 1 1], 'Normalization','none','Name','State')
    fullyConnectedLayer(500,'Name','ActorFC1')
    reluLayer('Name','ActorRelu1')
    fullyConnectedLayer(500,'Name','ActorFC2')
    reluLayer('Name','ActorRelu2')
    fullyConnectedLayer(numAct,'Name','Action')];

opts = rlRepresentationOptions('LearnRate',1e-5,'GradientThreshold',1);

actor = rlDeterministicActorRepresentation(actorNet, obsInfo, actInfo, ...
    'Observation', {'State'}, 'Action', {'Action'}, opts);
end
