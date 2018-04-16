# -*- coding: utf-8 -*-

import numpy as np
from copy import copy
from itertools import combinations

class Job(object):
  def __init__(self, p, d):
    self.p = p
    self.d = d

  def __str__(self):
    return "[{}|{}]".format(self.p, self.d)

  @staticmethod
  def evaluate(lojobs):
    end_time = [lojobs[0].p]
    for i in range(1, len(lojobs)):
      et = end_time[-1] + lojobs[i].p
      end_time.append(et)
    delay = 0
    for i in range(len(lojobs)):
      delay += max(0, end_time[i] - lojobs[i].d)
    # print(end_time, delay)
    return delay

jobs = [
  Job(1, 5),
  Job(2, 9),
  Job(3, 6),
  Job(4, 4)
]


class LocalSearch(object):
  def __init__(self, s0):
    self.s0 = s0

  def neighbor(self, s):
    for comb in  combinations(range(len(s)), 2):
      # swap
      ss = copy(s)
      ss[comb[0]] = s[comb[1]]
      ss[comb[1]] = s[comb[0]]
      yield ss

  def improve(self, s):
    sv = Job.evaluate([jobs[i] for i in s])
    lans = []
    for ss in self.neighbor(s):
      ans = Job.evaluate([jobs[i] for i in ss])
      if ans < sv:
        lans.append(ss)
    if len(lans) > 0:
      idx = np.random.choice(range(len(lans)))
      return lans[idx], len(lans)
    else:
      return s, 0

  def solve(self):
    s = self.s0
    s, lN = self.improve(s)
    while lN > 0:
      s, lN = self.improve(s)

    # answer
    lojobs = [jobs[i] for i in s]
    ans = Job.evaluate(lojobs)
    return ans, s


if __name__ == '__main__':
  N = len(jobs)
  np.random.seed(0)
  s0 = np.random.permutation(N)
  lojobs = [jobs[i] for i in s0]
  # Job.evaluate(lojobs)

  alg = LocalSearch(s0)
  ans, sans = alg.solve()
  print(sans)
  print(ans)
