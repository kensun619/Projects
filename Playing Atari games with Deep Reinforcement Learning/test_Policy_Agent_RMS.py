# reference from Karpathy's Algorithm

import gym
from gym import wrappers
from Policy_Agent_RMS import preprocess_observations , apply_neural_nets,choose_action,discount_with_rewards,update_weights,compute_gradient
import numpy as np
import matplotlib.pyplot as plt
from scipy.misc import imresize
import time


def main():
    env = gym.make("Pong-v0")
    problem = "Pong"
    env = wrappers.Monitor(env, problem + 'Video/', force = True)
    observation = env.reset()

    batch_size = 10
    gamma = 0.99
    decay_rate = 0.99
    num_hidden_layer_neurons = 200
    input_dimensions = 80 * 80
    learning_rate = 1e-4

    episode_number = 0
    reward_sum = 0
    running_reward = None
    prev_processed_observations = None

    weights = {
        '1': np.random.randn(num_hidden_layer_neurons, input_dimensions) / np.sqrt(input_dimensions),
        '2': np.random.randn(num_hidden_layer_neurons) / np.sqrt(num_hidden_layer_neurons)
    }

    expectation_g_squared = {}
    g_dict = {}
    for layer_name in weights.keys():
        expectation_g_squared[layer_name] = np.zeros_like(weights[layer_name])
        g_dict[layer_name] = np.zeros_like(weights[layer_name])

    episode_hidden_layer_values, episode_observations, episode_gradient_log_ps, episode_rewards = [], [], [], []

    while episode_number < 10000:
        env.render()
        processed_observations, prev_processed_observations = preprocess_observations(observation,
                                                                                      prev_processed_observations,
                                                                                      input_dimensions)

        hidden_layer_values, up_probability = apply_neural_nets(processed_observations, weights)
        episode_observations.append(processed_observations)
        episode_hidden_layer_values.append(hidden_layer_values)
        action = choose_action(up_probability)


        observation, reward, done, info = env.step(action)

        reward_sum += reward
        episode_rewards.append(reward)


        fake_label = 1 if action == 2 else 0
        loss_function_gradient = fake_label - up_probability
        episode_gradient_log_ps.append(loss_function_gradient)

        if done:
            episode_number += 1

            print('Current Episode: ' + str(episode_number) + ' Finished')


            episode_hidden_layer_values = np.vstack(episode_hidden_layer_values)
            episode_observations = np.vstack(episode_observations)
            episode_gradient_log_ps = np.vstack(episode_gradient_log_ps)
            episode_rewards = np.vstack(episode_rewards)

            episode_gradient_log_ps_discounted = discount_with_rewards(episode_gradient_log_ps, episode_rewards, gamma)

            gradient = compute_gradient(
                episode_gradient_log_ps_discounted,
                episode_hidden_layer_values,
                episode_observations,
                weights
            )
            for layer_name in gradient:
                g_dict[layer_name] += gradient[layer_name]

            if episode_number % batch_size == 0:
                update_weights(weights, expectation_g_squared, g_dict, decay_rate, learning_rate)

                print('Weights updated')

            episode_hidden_layer_values, episode_observations, episode_gradient_log_ps, episode_rewards = [], [], [], []  # reset values

            observation = env.reset()  # reset env
            running_reward = reward_sum if running_reward is None else running_reward * 0.99 + reward_sum * 0.01

            print('resetting env. episode reward total was %f. running mean: %f' % (reward_sum, running_reward))
            reward_sum = 0
            prev_processed_observations = None


main()
