# -*- coding: utf-8 -*-

import numpy as np
import pystan
import matplotlib.pyplot as plt


if __name__ == '__main__':
    data_np = np.loadtxt("./input/data-salary.txt", delimiter=",", skiprows=1)
    data = {
        "N": data_np.shape[0],
        "X": data_np[:, 0],
        "Y": data_np[:, 1]
    }
    fm = pystan.StanModel(file="./sources/stan_example2.stan")
    fit = fm.sampling(data=data, iter=1000, chains=4)
    fit.plot()
    plt.savefig("./output/output_example2.png", dpi=300)
