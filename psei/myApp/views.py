from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.models import User, auth
from django.contrib import messages
from pandas.core.frame import DataFrame
from .models import Feature

import pandas as pd
import numpy as np
from sklearn import metrics
import matplotlib.pyplot as plt
from io import StringIO
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import confusion_matrix, accuracy_score
import math

# Create your views here.
def index(request):
    features = Feature.objects.all()
    return render(request, 'index.html', {'features': features})

def register(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        password = request.POST['password']
        password2 = request.POST['password2']

        if password == password2:
            if User.objects.filter(email=email).exists():
                messages.info(request, 'Email already used')
                return redirect('register')
            elif User.objects.filter(username=username).exists():
                messages.info(request, 'Username already used')
                return redirect('register')
            else:
                user = User.objects.create_user(username=username, email=email, password=password)
                user.save();
                return redirect('login')
        else:
            messages.info(request, 'Password not the same')
            return redirect('register')
    else:
        return render(request, 'register.html')

def login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = auth.authenticate(username=username, password=password)

        if user is not None:
            auth.login(request, user)
            return redirect('/')
        else:
            messages.info(request, 'Credentials invalid')
            return redirect('login')
    else:
        return render(request, 'login.html')

def logout(request):
    auth.logout(request)
    return redirect('/')

def counter(request):
    posts = [1, 2, 3, 4, 5, 'tim', 'tom', 'john']
    return render(request, 'counter.html', {'posts': posts})

def post(request, pk):
    return render(request, 'post.html', {'pk': pk})

def chart(request):
    dataset = pd.read_csv('test-dataset.csv')
    dataset['date'] = pd.to_datetime(dataset.timestamp)
    datasetHead = dataset.head()
    datasetDescribe = dataset.describe()

    #knn regression
    X  = dataset[['open','high','low','volume']]
    y = dataset['close']

    #separate training and testing
    X_train , X_test , y_train , y_test = train_test_split(X ,y , random_state = 0)
        
    #train
    regressor = LinearRegression()
    regressor.fit(X_train,y_train)

    coef = regressor.coef_

    predicted=regressor.predict(X_test)

    dframe=pd.DataFrame(y_test,predicted)
    dfr=pd.DataFrame({'Actual':y_test,'Predicted':predicted})

    #check accuracy
    score = regressor.score(X_test,y_test)
    mae = metrics.mean_absolute_error(y_test,predicted)
    mse = metrics.mean_squared_error(y_test,predicted)
    rmse = math.sqrt(metrics.mean_squared_error(y_test,predicted))

    if request.method == 'POST':
        userOpen = float(request.POST['userOpen'])
        userHigh = float(request.POST['userHigh'])
        userLow = float(request.POST['userLow'])
        userVolume = int(request.POST['userVolume'])
        userParameters = [[userOpen, userHigh, userLow, userVolume]]
        predictedValue = regressor.predict(userParameters)

    else:
        userOpen = ''
        userHigh = ''
        userLow = ''
        userVolume = ''
        predictedValue = ''

    mydick = {
        'dataset': dataset.to_html(),
        'datasetHead': datasetHead.to_html(),
        'datasetDescribe': datasetDescribe.to_html(),
        'graph': return_graph(dataset),
        'coef': coef,
        'xtest': X_test,
        'dfr': dfr.to_html(),
        'score': score,
        'mae': mae,
        'mse': mse,
        'rmse': rmse,
        'userOpen': userOpen,
        'userHigh': userHigh,
        'userLow': userLow,
        'userVolume': userVolume,
        'predictedValue': predictedValue,
    }
    return render(request, 'chart.html', context=mydick)

def return_graph(dataset):
    fig = plt.figure(figsize=(16,6))
    plt.plot(dataset['open'])

    imgdata = StringIO()
    fig.savefig(imgdata, format='svg')
    imgdata.seek(0)

    data = imgdata.getvalue()
    
    return data