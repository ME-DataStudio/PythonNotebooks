import pickle
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import colors
import matplotlib.pyplot as plt
%matplotlib inline
from sklearn.cluster import KMeans

X_train, y_train = pickle.load(open("train_X_y.p", "rb"))
X_train_windows = [[line for line in array] for array in X_train]

t=np.vstack(X_train_windows)
#X_train_points = [x,y,z for x,y,z in X_train_windwos]

km = KMeans(n_clusters=3, init='k-means++', n_init=10, max_iter=300, tol=1e-04, random_state=0)


#X_train_frag=[]
#for fragmentid,fragment in enumerate(X_train):
#   X_train_frag.append ([X_train[fragmentid][i:i+3] for i in range(len(X_train[fragmentid])-2)])
km_pred = km.fit_predict(t)
np.array(X_train_windows).shape
np.array(X_train_frag).shape


def sliding_window(InArray):
    