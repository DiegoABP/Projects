import gymnasium as gym
import ray
import warnings
import logging
warnings.filterwarnings("ignore")
import time
import os

# from gym_examples.envs.matchingnetwork_world import MatchingNetworkEnv
from ray.rllib.algorithms.ppo import PPOConfig
from pprint import pprint,pformat

ray.init(logging_level=logging.ERROR,log_to_driver=True, num_cpus = 4, num_gpus =0) #ignore_reinit_error=True)

print(ray.available_resources())

from ray.rllib.algorithms.algorithm import Algorithm
config = PPOConfig().training(train_batch_size = 256, sgd_minibatch_size = 128).framework('torch').rollouts(num_rollout_workers =1).evaluation(evaluation_config=PPOConfig.overrides(render_env=True))


#algo = config.build(env='Humanoid-v4')
#algo.restore("/home/neo/ray_results/PPO/PPO_Humanoid-v4_ea03a_00000_0_2023-06-10_17-21-31/checkpoint_002220/")

algo = Algorithm.from_checkpoint("/home/jufallas/ray_results/PPO/PPO_Hopper-v4_f1d41_00000_0_2023-06-17_03-18-38/checkpoint_000020/")
#algo = Algorithm.from_checkpoint("/home/neo/ray_results/PPO/PPO_Humanoid-v4_47c54_00000_0_2023-06-12_14-37-08/checkpoint_000020/")
#algo = Algorithm.from_checkpoint("/home/neo/ray_results/PPO/PPO_Humanoid-v4_155be_00000_0_2023-06-11_14-51-14/checkpoint_000050/")

env = gym.make("Hopper-v4", render_mode= "human")
obs, info = env.reset()
episode_reward = 0
num_episodes = 0
while num_episodes < 50:
    
    action = algo.compute_single_action(obs)
    
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
