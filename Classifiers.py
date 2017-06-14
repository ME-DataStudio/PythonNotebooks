from sklearn import tree
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import Perceptron
from sklearn.svm import SVC

clf = tree.DecisionTreeClassifier()

## CHALLENGE - create 3 more classifiers...
#1 gaussian naive bayes
clfNBC = GaussianNB()
#2 perceptron (regression)
clfPrc = Perceptron()
#3
clfSVC = SVC()

#[height, weight, shoe_size]
X = [[181, 80, 44], [177, 70, 43], [160, 60, 38], [154, 54, 37], [166, 65, 40], [190, 90, 47], [175, 64, 39],
     [177, 70, 40], [159, 55, 37], [171, 75, 42], [181, 85, 43]]

Y = ['male', 'male', 'female', 'female', 'male', 'male', 'female', 'female', 'female', 'male', 'male']


#CHALLENGE - ...and train them on our data
clf = clf.fit(X, Y)
clfNBC = clfNBC.fit(X, Y)
clfPrc = clfPrc.fit(X, Y)
clfSVC = clfSVC.fit(X, Y)

prediction = clf.predict([[190, 70, 43],[177,78,39],[166,90,35]])
predictionNBC = clfNBC.predict([[190, 70, 43],[177,78,39],[166,90,35]])
predictionPrc = clfPrc.predict([[190, 70, 43],[177,78,39],[166,90,35]])
predictionSVC = clfSVC.predict([[190, 70, 43],[177,78,39],[166,90,35]])
#CHALLENGE compare their reusults and print the best one!

print(prediction)
print(predictionNBC)
print(predictionPrc)
print(predictionSVC)