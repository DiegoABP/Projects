
import logging    
import gymnasium as gym
import ray
from ray.rllib.algorithms.ppo import PPOConfig
from ray import air, tune

ray.init(logging_level=logging.ERROR,log_to_driver=True, num_cpus=15)
print(ray.available_resources())


config = PPOConfig().environment("Hopper-v4").training(train_batch_size = 160000, sgd_minibatch_size = 32768, lr=.0001, gamma=0.995).framework('torch').rollouts(num_rollout_workers =1).evaluation(
      evaluation_interval=1,
      evaluation_duration=2,
    evaluation_num_workers=1,
    evaluation_config=PPOConfig.overrides(render_env=True)).resources(num_gpus=1)

# trainer = PPOTrainer(env="Humanoid-v4", config=config)

tune.Tuner(
        "PPO",
        param_space=config.to_dict(),
       run_config=air.RunConfig(
            stop={"training_iteration": 60},
            checkpoint_config=air.CheckpointConfig(
                checkpoint_frequency=2, checkpoint_at_end=True
            ),
        ),
    ).fit()


