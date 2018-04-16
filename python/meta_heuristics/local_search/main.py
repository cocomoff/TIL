# -*- coding: utf-8 -*-

import numpy as np

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
    print(end_time, delay)
    return delay

jobs = [
  Job(1, 5),
  Job(2, 9),
  Job(3, 6),
  Job(4, 4)
]




if __name__ == '__main__':
  N = len(jobs)
  s0 = np.random.permutation(N)
  lojobs = [jobs[i] for i in s0]
  Job.evaluate(lojobs)
