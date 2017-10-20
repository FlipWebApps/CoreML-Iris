import numpy as np
from sklearn import datasets
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression

# load iris dataset and set features / target.
iris = datasets.load_iris()
indices = np.random.permutation(len(iris.data))
iris_X = iris.data[indices[:-10]]
iris_y = iris.target[indices[:-10]]

print("Data For Testing:")
print(iris.data[indices[-10:]])
print(iris.target[indices[-10:]])

# Create and fit a model
model = LogisticRegression()
model.fit(iris_X, iris_y)
cross_score = cross_val_score(model, iris_X, iris_y, cv=10)
print "Cross Validation Scores"
print cross_score
print "mean:",np.mean(cross_score)

import coremltools
# convert to coreml model
coreml_model = coremltools.converters.sklearn.convert(model, iris.feature_names, "class")

# set parameters of the model
coreml_model.short_description = "Iris dataset classification model"
coreml_model.output_description["class"] = "The species of flower"

# Save the model
coreml_model.save("iris_logistic_regression.mlmodel")