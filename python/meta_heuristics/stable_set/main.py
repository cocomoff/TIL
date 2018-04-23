# -*- coding: utf-8 -*-

import math
import random
import numpy as np


def rnd_graph_fast(nnodes, prob):
  nodes = range(nnodes)
  adj = [[] for i in nodes]
  i = 1
  j = -1
  logp = math.log(1.0 - prob)
  while i < nnodes:
    logr = math.log(1.0 - random.random())
    j += 1 + int(logr / logp)
    while j >= i and i < nnodes:
      j -= i
      i += 1
    if i < nnodes:
      adj[i].append(j)
      adj[j].append(i)
  return nodes, adj


def evaluate(nodes, adj, sol):
  card = len(sol)
  b = [0 for i in nodes]
  infeas = 0
  for i in sol:
    for j in adj[i]:
      b[j] += 1
      if j in sol:
        infeas += 1
  return card, infeas / 2, b


def construct(nodes, adj):
  sol = set([])
  b = [0 for i in nodes]
  indices = list(nodes)
  random.shuffle(indices)
  for ii in nodes:
    i = indices[ii]
    if b[i] == 0:
      sol.add(i)
      for j in adj[i]:
        b[j] += 1
  return sol


def find_add(nodes, adj, sol, b, tabu, iteration):
  xdelta = np.Inf
  istar = []
  for i in set(nodes) - sol:
    if tabu[i] <= iteration:
      delta = b[i]
      if delta < xdelta:
        xdelta = delta
        istar = [i]
      elif delta == xdelta:
        istar.append(i)

  if istar != []:
    return random.choice(istar)
  tabu = [0 for i in nodes]
  return find_add(nodes, adj, sol, b, tabu, iteration)


def find_drop(nodes, adj, sol, b, tabu, iteration):
  xdelta = -np.Inf
  istar = []
  for i in sol:
    if tabu[i] <= iteration:
      delta = b[i]
      if delta > xdelta:
        xdelta = delta
        istar = [i]
      elif delta == xdelta:
        istar.append(i)

  if istar != []:
    return random.choice(istar)
  tabu = [0 for i in nodes]
  return find_drop(nodes, adj, sol, b, tabu, iteration)


def move_in(nodes, adj, sol, b, tabu, tabuIN, tabuOUT, iteration):
  i = find_add(nodes, adj, sol, b, tabu, iteration)
  tabu[i] = iteration + tabuIN
  sol.add(i)
  deltainfeas = 0
  for j in adj[i]:
    b[j] += 1
    if j in sol:
      deltainfeas += 1
  return deltainfeas


def move_out(nodes, adj, sol, b, tabu, tabuIN, tabuOUT, iteration):
  i = find_drop(nodes, adj, sol, b, tabu, iteration)
  tabu[i] = iteration + tabuOUT
  sol.remove(i)
  deltainfeas = 0
  for j in adj[i]:
    b[j] -= 1
    if j in sol:
      deltainfeas -= 1
  return deltainfeas


def tabu_search(nodes, adj, sol, max_iter, tabulen):
  n = len(nodes)
  tabu = [0 for i in nodes]
  card, infeas, b = evaluate(nodes, adj, sol)
  bestsol, bestcard = set(sol), card
  for it in range(max_iter):
    tabuIN = 1 + int(tabulen / 100. * card)
    tabuOUT = 1 + int(tabulen / 100. * (n-card))
    if infeas == 0:
      infeas += move_in(nodes, adj, sol, b, tabu, tabuIN, tabuOUT, it)
      card += 1
    else:
      infeas += move_out(nodes, adj, sol, b, tabu, tabuIN, tabuOUT, it)
      card -= 1
    if infeas == 0 and card > bestcard:
      bestsol, bestcard = set(sol), card
  return bestsol, bestcard


if __name__ == '__main__':
  V, E = rnd_graph_fast(100, 0.5)
  max_iter = 1000
  tabulen = 10
  sol = construct(V, E)
  sol, cost = tabu_search(V, E, sol, max_iter, tabulen)
  print(sol)
  print(cost)
