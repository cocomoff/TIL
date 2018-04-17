# -*- coding: utf-8 -*-

import math
import random
import numpy as np

def rnd_graph(nnodes, prob):
  nodes = range(nnodes)
  adj = [[] for i in nodes]
  for i in range(nnodes - 1):
    for j in range(i + 1, nnodes):
      if random.random() < prob:
        adj[i].append(j)
        adj[j].append(i)

  return nodes, adj


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


def construct(nodes):
  sol = [0 for i in nodes]
  for i in range(len(nodes) // 2):
    sol[i] = 1
  return sol


def evaluate(nodes, adj, sol):
  cost = 0
  s = [0 for i in nodes]
  d = [0 for i in nodes]
  for i in nodes:
    for j in adj[i]:
      if sol[i] == sol[j]:
        s[i] += 1
      else:
        d[i] += 1
  for i in nodes:
    cost += d[i]
  return cost / 2, s, d


def find_move(part, nodes, adj, sol, s, d, tabu, tabulen, iteration):
  mindelta = np.Inf
  istar = None
  for i in nodes:
    if sol[i] != part:
      if tabu[i] <= iteration:
        delta = s[i] - d[i]
        if delta < mindelta:
          mindelta = delta
          istar = i

  if istar != None:
    return istar, mindelta
  tabu = [0 for i in nodes]
  return find_move(part, nodes, adj, sol, s, d, tabu, tabulen, iteration)


def move(part, nodes, adj, sol, s, d, tabu, tabulen, iteration):
  i, delta = find_move(part, nodes, adj, sol, s, d, tabu, tabulen, iteration)
  sol[i] = part
  tabu[i] = iteration + tabulen
  s[i], d[i] = d[i], s[i]
  for j in adj[i]:
    if sol[j] != part:
      s[j] -= 1
      d[j] += 1
    else:
      s[j] += 1
      d[j] -= 1
  return delta


def tabu_search(nodes, adj, sol, max_iter, tabulen):
  cost, s, d = evaluate(nodes, adj, sol)
  tabu = [0 for i in nodes]
  bestcost = np.Inf

  for it in range(max_iter):
    cost += move(1, nodes, adj, sol, s, d, tabu, tabulen, it)
    cost += move(0, nodes, adj, sol, s, d, tabu, tabulen, it)
    if cost < bestcost:
      bestcost = cost
      bestsol = list(sol)


  # answer
  print(bestcost)
  print(bestsol)
  return bestsol, bestcost


if __name__ == '__main__':
  V, E = rnd_graph_fast(100, 0.5)
  max_iter = 1000
  tabulen = 10
  sol = construct(V)
  sol, cost = tabu_search(V, E, sol, max_iter, tabulen)
