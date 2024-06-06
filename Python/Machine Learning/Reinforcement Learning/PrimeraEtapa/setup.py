import logging    
import gymnasium as gym
import ray
from ray.rllib.algorithms.dqn.dqn import DQNConfig
from ray import air
from ray import tune

ray.init(logging_level=logging.ERROR,log_to_driver=True, num_cpus=16)
print(ray.available_resources())

config = {
    'env':'ALE/SpaceInvaders-v5',
    # Works for both torch and tf.
    'framework': 'torch',
    # Make analogous to old v4 + NoFrameskip.
    'env_config':{
        'frameskip': 1,
        'full_action_space': 'false',
        'repeat_action_probability': 0.0,
    },
    'double_q': 'false',
    'dueling': 'false',
    'num_atoms': 1,
    'noisy': 'false',
    'num_steps_sampled_before_learning_starts': 20000,
    'n_step': 1,
    'target_network_update_freq': 8000,
    'lr': .000625,
    'adam_epsilon': .00015,
    'hiddens': [512],
    'rollout_fragment_length': 4,
    'train_batch_size': 32,
    'exploration_config':{
        'epsilon_timesteps': 200000,
        'final_epsilon': 0.01,
    },
    'num_workers': 15,
    'num_gpus': 1,
    'min_sample_timesteps_per_iteration': 10000,
    
}

tune.Tuner( 
    "DQN",
    run_config=air.RunConfig(
        stop={"training_iteration": 10000},
        checkpoint_config=air.CheckpointConfig(
            checkpoint_frequency=20, checkpoint_at_end=True
        ),
    ),
    param_space=config
).fit()
