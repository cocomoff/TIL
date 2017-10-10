# -*- coding: utf-8 -*-

import pystan
import matplotlib.pyplot as plt


if __name__ == '__main__':
    data = {
        "J": 8,
        "y": [28, 8, -3, 7, -1, 1, 18, 12],
        "sigma": [15, 10, 16, 11, 9, 11, 10, 18]
    }
    fm = pystan.StanModel(file="pystan_example1.stan")
    fit = fm.sampling(data=data, iter=1000, chains=4)
    fit.plot()
    plt.savefig("output_example1.png", dpi=300)
