# -*- coding: utf-8 -*-

# -*- coding: utf-8 -*-

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.animation as anim
import seaborn as sns


class CellAutomaton(object):
  def __init__(self, N, theta=0.3, rule_no=90):
    self.N = N
    self.theta = theta

    # binary rule
    self.rule_no = rule_no
    self.rule_no_bin = bin(self.rule_no)[2:]
    if len(self.rule_no_bin) < 8:
      self.rule_no_bin = "0" * (8 - len(self.rule_no_bin)) + self.rule_no_bin

    # initialize
    self.array = np.zeros(N, dtype=np.int8)
    for i in range(N):
      if np.random.rand() < self.theta:
        self.array[i] = 1

  def print_array(self):
    print(self.array)

  def forward(self):
    new_array = np.zeros_like(self.array)
    for i in range(self.N):
      rl = max(0, i - 1)
      rr = min(i + 2, self.N)
      ai = self.array[rl:rr]
      if i == 0:
        ai = np.r_[self.array[-1], ai]
      elif i == self.N - 1:
        ai = np.r_[ai, self.array[0]]

      # array to bin str
      ai_bin = "".join(map(lambda x: "{}".format(x), list(ai)))
      ai_bin_idx = int(ai_bin, 2)

      # get next value
      next_value = self.rule_no_bin[ai_bin_idx]
      new_array[i] = int(next_value)

      # debug
      # print(rl, rr, ai_bin, ai_bin_idx, next_value)

    # update 
    self.array = new_array

  def display(self):
    plt.figure(figsize=(self.N // 10, 2))
    plt.imshow(self.array.reshape((1, self.N)),
               interpolation='none', cmap='Blues')
    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    plt.show()
    plt.close()

  def animation(self, step):
    fig = plt.figure(figsize=(self.N // 10, 2))
    artists = []
    for i in range(step):
      im = plt.imshow(self.array.reshape((1, self.N)),
                      interpolation='none', cmap='Blues')
      artists.append([im])
      self.forward()
    ani = anim.ArtistAnimation(fig, artists, interval=100, repeat=True)
    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    plt.show()

  def image(self, step):
    array = np.zeros((step, self.N))
    array[0, :] = self.array
    for i in range(step):
      self.forward()
      array[i, :] = self.array
    return array

  def plot_image(self, step):
    array = self.image(step)
    plt.imshow(array, interpolation='none', cmap='Blues')
    plt.xticks([])
    plt.yticks([])
    plt.tight_layout()
    plt.show()
    plt.close()
      

if __name__ == '__main__':
  ca = CellAutomaton(200, rule_no=90)
  ca.plot_image(step=200)
