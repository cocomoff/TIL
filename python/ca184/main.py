# -*- coding: utf-8 -*-

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.animation as anim
import seaborn as sns


class Cell(object):
  def __init__(self, N, theta=0.3, eta=0.8):
    self.N = N
    self.theta = theta
    self.eta = eta
    self.array = np.zeros(N, dtype=np.int8)
    for i in range(N):
      if np.random.rand() < self.theta:
        self.array[i] = 1

  def print_array(self):
    print(self.array)

  def forward(self):
    new_array = np.zeros_like(self.array)
    for i in range(self.N - 2, -1, -1):
      if self.array[i + 1] == 0 and self.array[i] == 1:
        new_array[i + 1] = 1
      elif self.array[i] == 1:
        new_array[i] = 1
    if np.random.rand() < self.eta:
      new_array[0] = 1
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
  cell = Cell(100)
  # cell.animation(step=100)
  cell.plot_image(step=100)
