import gymnasium as gym
import ray
import warnings
import logging
warnings.filterwarnings("ignore")
import time
import os

# from gym_examples.envs.matchingnetwork_world import MatchingNetworkEnv
from ray.rllib.algorithms.dqn import DQNConfig
from pprint import pprint,pformat

ray.init(logging_level=logging.ERROR,log_to_driver=True, num_cpus = 16, num_gpus =1) #ignore_reinit_error=True)

print(ray.available_resources())

from ray.rllib.algorithms.algorithm import Algorithm
config = DQNConfig().training(train_batch_size = 256).framework('torch').rollouts(num_rollout_workers =1).evaluation(evaluation_config=DQNConfig.overrides(render_env=True))


#algo = config.build(env='Humanoid-v4')
#algo.restore("/home/neo/ray_results/PPO/PPO_Humanoid-v4_ea03a_00000_0_2023-06-10_17-21-31/checkpoint_002220/")

algo = Algorithm.from_checkpoint("/home/jufallas/ray_results/DQN/DQN_ALE_SpaceInvaders-v5_f3192_00000_0_2023-06-19_12-48-58/checkpoint_000120/")
#algo = Algorithm.from_checkpoint("/home/neo/ray_results/PPO/PPO_Humanoid-v4_47c54_00000_0_2023-06-12_14-37-08/checkpoint_000020/")/
#algo = Algorithm.from_checkpoint("/home/neo/ray_results/PPO/PPO_Humanoid-v4_155be_00000_0_2023-06-11_14-51-14/checkpoint_000050/")

env = gym.make("ALE/SpaceInvaders-v5", render_mode= "human", full_action_space=True)
obs, info = env.reset()
episode_reward = 0
num_episodes = 0
while True:
    
    action = algo.compute_single_action(obs)
    print(action)
    
    obs, reward, terminated, truncated, info = env.step(action)
    env.render()
    episode_reward = episode_reward + reward
    print("reward is ...", episode_reward)
    if terminated or truncated:
        print(" reset ")
        obs, info = env.reset()
        num_episodes +=1
        episode_reward = 0.0

print('Finished')
