# -*- coding: utf-8 -*-

import math
import random
import numpy as np


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


def possible_add(rmn, b):
  return [i for i in rmn if b[i] == 0]


def one_edge(rmn, b):
  return [i for i in rmn if b[i] == 1]


def add_node(i, adj, sol, rmn, b):
  sol.add(i)
  rmn.remove(i)
  for j in adj[i]:
    b[j] += 1


def expand_rand(add, sol, rmn, b, adj, maxiter):
  iteration = 0
  while add != [] and iteration < maxiter:
    iteration += 1
    i = random.choice(add)
    add_node(i, adj, sol, rmn, b)
    add.remove(i)
    add = possible_add(add, b)
  return iteration


def plateau(sol, rmn, b, adj, maxiter):
  iteration = 0
  while iteration < maxiter:
    one = one_edge(rmn, b)
    if one == []:
      return iteration, []
    i = random.choice(one)
    iteration += 2
    add_node(i, adj, sol, rmn, b)
    expand_nodes = node_replace(i, sol, rmn, b, adj)
    if expand_nodes != []:
      return iteration, expand_nodes
  return iteration, []


def node_replace(i, sol, rmn, b, adj):
  connected = set(adj[i]).intersection(sol)
  j = connected.pop()
  rmn.add(j)
  sol.remove(j)
  expand_nodes = []
  for k in adj[j]:
    b[k] -= 1
    if b[k] == 0 and k not in sol:
      expand_nodes.append(k)
  return expand_nodes


def multistart_local_search(nodes, adj, niters, length):
  bestsol = []
  bestcard = 0
  iter = 0
  while iter < niters:
    add = list(nodes)
    rmn = set(nodes)
    sol = set([])
    b = [0 for i in nodes]
    while add != []:
      iter += expand_rand(add, sol, rmn, b, adj, niters - iter)
      if len(sol) > bestcard:
        bestcard = len(sol)
        bestsol = list(sol)
      maxiter = min(length, niters - iter)
      usediter, add = plateau(sol, rmn, b, adj, maxiter)
      iter += usediter
  return bestsol, bestcard


if __name__ == '__main__':
  V, E = rnd_graph_fast(100, 0.5)
  max_iter = 1000
  length = 10
  sol = construct(V, E)
  sol, cost = multistart_local_search(V, E, max_iter, length)
  print(sol)
  print(cost)
