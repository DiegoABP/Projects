import logging    
import gymnasium as gym
import ray
from ray.rllib.algorithms.apex_dqn.apex_dqn import ApexDQNConfig
from ray import air
from ray import tune

ray.init(logging_level=logging.ERROR,log_to_driver=True, num_cpus=16)
print(ray.available_resources())

config = {
    'env':'ALE/SpaceInvaders-v5',
    'framework': 'torch',
    # Works for both torch and tf.
    'env_config':{
        'frameskip': 1,
        'full_action_space': 'false',
        'repeat_action_probability': 0.0,
    },
    'double_q': 'false',
    'dueling': 'false',
    'num_atoms': 1,
    'noisy': 'false',
    'n_step': 3,
    'lr': .0001,
    'adam_epsilon': .00015,
    'hiddens': [512],
    'exploration_config':{
        'epsilon_timesteps': 200000,
        'final_epsilon': 0.01,
    },
    'num_gpus': 1,
    'num_workers': 15,
    'rollout_fragment_length': 20,
    'train_batch_size': 512,
    
}

tune.Tuner( 
    "APEX",
    run_config=air.RunConfig(
        stop={"training_iteration": 10000},
        checkpoint_config=air.CheckpointConfig(
            checkpoint_frequency=20, checkpoint_at_end=True
        ),
    ),
    param_space=config
).fit()
