# -*- coding: utf-8 -*-

import pickle
import numpy as np
import pystan
import matplotlib.pyplot as plt


def build():
    fm = pystan.StanModel(file="./sources/stan_example2.stan")
    with open("models/example2.pkl", "wb") as f:
        pickle.dump(fm, f, protocol=pickle.HIGHEST_PROTOCOL)
    return fm


if __name__ == '__main__':
    # fm = build()
    fm = pickle.load(open("models/example2.pkl", "rb"))
    data_np = np.loadtxt("./input/data-salary.txt", delimiter=",", skiprows=1)
    data = {
        "N": data_np.shape[0],
        "X": data_np[:, 0],
        "Y": data_np[:, 1]
    }
    fit = fm.sampling(data=data, iter=1000, chains=4)
    # fit.plot()
    # plt.savefig("./output/output_example2.png", dpi=300)
    ans = fit.extract()
    lp__ = ans["lp__"]
    print(lp__)

    """
    init = fit.get_inits()
    for idx in range(len(init)):
        od = init[idx]
        print("Chain {}".format(idx))
        print(od["a"])
        print(od["b"])
        print(od["sigma"])
        print()"""

    # 信頼区間 (see p.47)
    b = ans["b"]
    import numpy as np
    b1 = np.percentile(b, 2.5)
    b2 = np.percentile(b, 97.5)
    print(b1)
    print(b2)
