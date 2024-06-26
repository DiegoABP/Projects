#!pip install gymnasium --user
#!pip install gymnasium[atari]
#!pip install gymnasium[accept-rom-license]
#!pip install gymnasium[box2d]
#!pip install pygame
#!pip install keras-rl



import os 
## Suppress TensorFlow Info and Warnings
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

import gymnasium as gym
import random

env = gym.make("ALE/Riverraid-v5", render_mode="human")
#env = gym.make("ALE/Riverraid-v5", render_mode="rgb_array")
height,  width, channels = env.observation_space.shape
actions = env.action_space.n

env.unwrapped.get_action_meanings()

episodes = 5
for episode in range(1, episodes+1):
    state = env.reset()
    done = False
    score = 0 
    
    while not done:
        env.render()
        action = random.choice([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17])
        n_state, reward, done, info, _ = env.step(action)
        score+=reward
    print('Episode:{} Score:{}'.format(episode, score))
env.close()

import numpy as np
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Flatten, Convolution2D
from tensorflow.keras.optimizers import Adam

def build_model(height, width, channels, actions):
    model = Sequential()
    model.add(Convolution2D(32, (8,8), strides=(4,4), activation='relu', input_shape=(3,height, width, channels)))
    model.add(Convolution2D(64, (4,4), strides=(2,2), activation='relu'))
    model.add(Convolution2D(64, (3,3), activation='relu'))
    model.add(Flatten())
    model.add(Dense(512, activation='relu'))
    model.add(Dense(256, activation='relu'))
    model.add(Dense(actions, activation='linear'))
    return model

model = build_model(height, width, channels, actions)
model.summary()

#from rl.agents import DQNAgent
#from rl.memory import SequentialMemory
#from rl.policy import LinearAnnealedPolicy, EpsGreedyQPolicy

from rl.agents.dqn import DQNAgent
from rl.memory import SequentialMemory
from rl.policy import LinearAnnealedPolicy, EpsGreedyQPolicy

def build_agent(model, actions):
    policy = LinearAnnealedPolicy(EpsGreedyQPolicy(), attr='eps', value_max=1., value_min=.1, value_test=.2, nb_steps=10000)
    memory = SequentialMemory(limit=100000, window_length=3)
    dqn = DQNAgent(model=model, memory=memory, policy=policy,
                  enable_dueling_network=True, dueling_type='avg', 
                   nb_actions=actions, nb_steps_warmup=1000
                  )
    return dqn

dqn = build_agent(model, actions)
dqn.compile(Adam(lr=1e-4))

dqn.fit(env, nb_steps=10000, visualize=False, verbose=2)

scores = dqn.test(env, nb_episodes=10, visualize=True)
print(np.mean(scores.history['episode_reward']))



