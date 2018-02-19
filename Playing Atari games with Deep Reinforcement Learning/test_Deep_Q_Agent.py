import gym
from gym import wrappers
from DQN_Agent import DQN_Agent
import numpy as np
import matplotlib.pyplot as plt
from scipy.misc import imresize
import time
import os
import sys

problem = sys.argv[1]
folder = sys.argv[1] + "_" + sys.argv[2] + "/"
env = gym.make(problem)
env = wrappers.Monitor(env, folder + "Video/", force=True)
text_file = open(folder + "Output.txt", "w")
if not os.path.exists(folder + "Saved_Network/"):
    os.makedirs(folder + "Saved_Network/")
agent = DQN_Agent(problem, 400000, 400000, False, folder + "Saved_Network/model", 0)

observation = env.reset()
#observation = (0.33 * observation[:,:,0] + 0.33 * observation[:,:,1] + 0.33 * observation[:,:,2])/255
#observation = imresize(observation, (110, 84))
#observation = observation[18:102, :]
#plt.imshow(observation,aspect="auto")
#plt.show()


agent.initial_state(observation)
reward_sum = 0
i = 0
ep = 0
t = time.time()
e_t = 0
while ep < 100000:

    action = agent.next_action()
    observation, reward, done, _ = env.step(action)
    agent.read_observation(observation, action, reward, done)
    if reward > 0:
        reward = 1
    elif reward < 0:
        reward = -1
    else:
        reward = 0

    reward_sum += reward
    i += 1
    if done:
        average_q_value = agent.evoluate()
        episode_time = e_t
        e_t = time.time() - t
        episode_time = e_t - episode_time
        print ('total_step %i, loss %f, average_q_value %f, total_reward %i, episode_step %i, episode_time_in_s %f, total_train_time_in_min %f'
                                            % (agent.time_step, agent.loss_value, average_q_value, reward_sum, i, episode_time, e_t / 60))
        text_file.write('total_step %i, loss %f, average_q_value %f, total_reward %i, episode_step %i, episode_time_in_s %f, total_train_time_in_min %f\n'
                                            % (agent.time_step, agent.loss_value, average_q_value, reward_sum, i, episode_time, e_t / 60))
        ep += 1
        reward_sum = 0
        i = 0
        observation = env.reset()
        agent.initial_state(observation)

env.close()
text_file.close()
