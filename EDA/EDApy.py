# Regular EDA (exploratory data analysis) and plotting libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# %matplotlib inline

# Models from Scikit-learn
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier

# Model Evaluations
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.model_selection import RandomizedSearchCV, GridSearchCV
from sklearn.metrics import confusion_matrix, classification_report

df_raw = pd.read_csv("/home/krishna/Git-Workshop/clsz2.csv")
df_raw

df_raw.info()

df_raw.describe()

# Number of occurences for each size (target variable)
df_raw["size"].value_counts()

# Number of occurences for each size (target variable)
sns.countplot(x=df_raw["size"])

# Age distribution
sns.displot(df_raw["age"])

# Weight distribution
sns.displot(df_raw["weight"])

# height distribution
sns.displot(df_raw["height"])

# Removing Outliers
dfs = []
sizes = []
for size_type in df_raw['size'].unique():
    sizes.append(size_type)
    ndf = df_raw[['age','height','weight']][df_raw['size'] == size_type]
    zscore = ((ndf - ndf.mean())/ndf.std())
    dfs.append(zscore)
    
for i in range(len(dfs)):
    dfs[i]['age'] = dfs[i]['age'][(dfs[i]['age']>-3) & (dfs[i]['age']<3)]
    dfs[i]['height'] = dfs[i]['height'][(dfs[i]['height']>-3) & (dfs[i]['height']<3)]
    dfs[i]['weight'] = dfs[i]['weight'][(dfs[i]['weight']>-3) & (dfs[i]['weight']<3)]

for i in range(len(sizes)):
    dfs[i]['size'] = sizes[i]
df_raw = pd.concat(dfs)
df_raw.head()

# Check for missing values
df_raw.isna().sum()

# Filling missing data
df_raw["age"] = df_raw["age"].fillna(df_raw['age'].median())
df_raw["height"] = df_raw["height"].fillna(df_raw['height'].median())
df_raw["weight"] = df_raw["weight"].fillna(df_raw['weight'].median())

# Mapping clothes size from strings to numeric
df_raw['size'] = df_raw['size'].map({"XXS": 1,
                                     "S": 2,
                                     "M" : 3,
                                     "L" : 4,
                                     "XL" : 5,
                                     "XXL" : 6,
                                     "XXXL" : 7})

# Check for missing values
df_raw.isna().sum()

df_raw

# feature eng
df_raw["bmi"] = df_raw["height"]/df_raw["weight"]
df_raw["weight-squared"] = df_raw["weight"] * df_raw["weight"]


df_raw

corr = sns.heatmap(df_raw.corr(), annot=True)

# splitting train test 
# Features
X = df_raw.drop("size", axis=1)

# Target
y = df_raw["size"]

X.head()

y.head()

# Splitting data into training set and validation set

X_train, X_test, y_train, y_test, = train_test_split(X,y, test_size=0.10)

len(X_train), len(X_test)

# Put models in a dictionary
models = {"Logistic Regression": LogisticRegression(),
         "KNN": KNeighborsClassifier(),
         "Random Forest": RandomForestClassifier(),
         "Decision Tree": DecisionTreeClassifier()}

# Create a function to fit and score models
def fit_and_score(models, X_train, X_test, y_train, y_test):
   
    """
   Fits and evaluates given machine learning models.
   models: a dict of different Scikit_Learn machine learning models
   X_train: training data (no labels)
   X_test: testing data (no labels)
   y_train: training labels
   y_test: test labels
   """ 
    # Set random seed
    np.random.seed(18)
    # Make a dictionary to keep model scores
    model_scores = {}
    # Loop through models
    for name, model in models.items():
        # Fit model to data
        model.fit(X_train, y_train)
        # Evaluate model and append its score to model_scores
        model_scores[name] = model.score(X_test, y_test)

    return model_scores

model_scores = fit_and_score(models,X_train,X_test,y_train,y_test)

model_scores

model_compare = pd.DataFrame(model_scores, index=["accuracy"])
model_compare.T.plot.bar();

model = DecisionTreeClassifier()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

# Confusion matrix
print(confusion_matrix(y_test, y_pred))

# Classification report
print(classification_report(y_test, y_pred))

#conclusion ac--99.9% 'Logistic Regression': 0.2548855854351094,
 #'KNN': 0.9028728912644062,
 #'Random Forest': 0.9981626858192751,
 #'Decision Tree': 0.9995824285952898}
